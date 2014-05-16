//
//  SSPChatViewController.m
//  SecretSpice
//
//  Created by Kevin on 16/05/14.
//  Copyright (c) 2014 UIKonf. All rights reserved.
//

#import "SSPChatViewController.h"
#import "JSQMessage.h"
#import "JSQSystemSoundPlayer.h"
#import "JSQSystemSoundPlayer+JSQMessages.h"
#import "JSQMessagesBubbleImageFactory.h"
#import "UIColor+JSQMessages.h"
#import "JSQMessagesTimestampFormatter.h"
#import "JSQMessagesCollectionViewCell.h"
#import "SSPMessagingHelper.h"
#import "JSQMessagesInputToolbar.h"
#import "JSQMessagesToolbarContentView.h"
#import "JSQMessagesComposerTextView.h"
#import "PNChannel.h"
#import "PNMessage.h"
#import "PNDate.h"
#import "SSPUserStore.h"
#import "SSPConversation.h"
#import "SSPPerson.h"

@interface SSPChatViewController ()

@property (nonatomic, strong) NSMutableArray *messages;
@property (nonatomic, strong) UIImageView *sentMessageBubble;
@property (nonatomic, strong) UIImageView *receivedMessageBubble;
@property (nonatomic, strong) SSPPerson *volunteer;
@property (nonatomic, strong) PNChannel *currentChannel;

@end

@implementation SSPChatViewController

- (instancetype)initWithSelectedVolunteer:(id)volunteer {
    
    if (self = [super init]) {
        self.volunteer = volunteer;
    }
    
    return self;
}

- (instancetype)initWithConversation:(SSPConversation *)conversation {
    
    if (self = [super init]) {
        self.currentChannel = conversation.channel;
        self.messages = conversation.messages;
        self.title = conversation.volunteerName;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initializeComponents];
    [self listenToMessages];
    
    BOOL connectionStarted = [SSPUserStore sharedStore].isConnectionToMessagingActive;
    if (!connectionStarted)
        [self startConnection];
    else {
        [self initializeChannelAndView];
    }
}

- (void)initializeComponents {
    
    if (!self.messages)
        self.messages = [[NSMutableArray alloc] init];
    
    self.sentMessageBubble = [JSQMessagesBubbleImageFactory
                                    outgoingMessageBubbleImageViewWithColor:[UIColor jsq_messageBubbleLightGrayColor]];
    self.receivedMessageBubble = [JSQMessagesBubbleImageFactory
                                  outgoingMessageBubbleImageViewWithColor:[UIColor jsq_messageBubbleBlueColor]];
    self.sender = USER_NAME;
    
    [self setTextViewEnabled:NO];
}

#pragma mark - UI

- (void)setTextViewEnabled:(BOOL)enabled {
    
    JSQMessagesComposerTextView *textView = self.inputToolbar.contentView.textView;
    [textView setUserInteractionEnabled:enabled];
}

- (void)createMessageBubbleWithText:(NSString *)text sender:(NSString *)sender andDate:(NSDate *)date  {
    
    [JSQSystemSoundPlayer jsq_playMessageSentSound];
    
    JSQMessage *message = [[JSQMessage alloc] initWithText:text sender:sender date:date];
    [self.messages addObject:message];
    
    [self finishSendingMessage];
}

#pragma mark - Channel connection

- (void)subscribeToVolunteer: (id)volunteer {
    
    self.currentChannel = [SSPMessagingHelper subscribeToChannelName:self.volunteer.channel];
    [self addConversationToStore];
}

- (void)addConversationToStore {
    
    NSString *volunteerName = self.volunteer.name;
    
    self.title = volunteerName;
    
    SSPConversation *conversation = [[SSPConversation alloc] initWithVolunteerName:volunteerName channel:self.currentChannel messages:self.messages];
    [[SSPUserStore sharedStore].conversations addObject:conversation];
}

- (void)startConnection {
    
    [SSPUserStore sharedStore].isConnectionToMessagingActive = YES;
    [SSPMessagingHelper startConnectionWithBlock:^(NSString *origin) {
        
        [self initializeChannelAndView];
        
    } errorBlock:^(PNError *connectionError) {
        
    }];
}

- (void)initializeChannelAndView {
    
    if (!self.currentChannel) {
        [self subscribeToVolunteer:self.volunteer];
    }
    [self setTextViewEnabled:YES];
}

- (void)listenToMessages {
    
    //TODO: weakify
    
    [SSPMessagingHelper listenToMessagesWithBlock:^(PNMessage *message) {
        
        if ([message.channel.name isEqualToString:self.currentChannel.name]) {
            
            NSLog (@"%@", message.message);
            
            NSDictionary *messageDataDictionary = message.message;
            
            NSString *text = [messageDataDictionary valueForKey:@"message"];
            NSString *sender = [messageDataDictionary valueForKey:@"sender"];
            NSDate *date = [NSDate date];
            
            [self createMessageBubbleWithText:text sender:sender andDate:date];
        }
        
    }];
}

- (void)sendMessage:(NSString *)message {
    
    NSDictionary *dataDictionary = @{
                           @"sender":self.sender,
                           @"message":message
                           };
    NSData *data = [NSJSONSerialization dataWithJSONObject:dataDictionary options:0 error:nil];
    NSString *stringData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    [SSPMessagingHelper sendMessage:stringData ToChannel:self.currentChannel andCompletionBlock:^(PNMessageState messageState, id error) {
    }];
}

#pragma mark - Overrided methods

- (void)didPressSendButton:(UIButton *)button
           withMessageText:(NSString *)text
                    sender:(NSString *)sender
                      date:(NSDate *)date
{
    [self sendMessage:text];
}

#pragma mark - Data source

- (id<JSQMessageData>)collectionView:(JSQMessagesCollectionView *)collectionView messageDataForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.messages objectAtIndex:indexPath.item];
}

- (UIImageView *)collectionView:(JSQMessagesCollectionView *)collectionView bubbleImageViewForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JSQMessage *message = [self.messages objectAtIndex:indexPath.item];
    
    if ([message.sender isEqualToString:self.sender]) {
        return [[UIImageView alloc] initWithImage:self.sentMessageBubble.image
                                 highlightedImage:self.sentMessageBubble.highlightedImage];
    }
    
    return [[UIImageView alloc] initWithImage:self.receivedMessageBubble.image
                             highlightedImage:self.receivedMessageBubble.highlightedImage];
}

- (UIImageView *)collectionView:(JSQMessagesCollectionView *)collectionView avatarImageViewForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (NSAttributedString *)collectionView:(JSQMessagesCollectionView *)collectionView attributedTextForCellTopLabelAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item % 3 == 0) {
        JSQMessage *message = [self.messages objectAtIndex:indexPath.item];
        return [[JSQMessagesTimestampFormatter sharedFormatter] attributedTimestampForDate:message.date];
    }
    
    return nil;
}

- (NSAttributedString *)collectionView:(JSQMessagesCollectionView *)collectionView attributedTextForMessageBubbleTopLabelAtIndexPath:(NSIndexPath *)indexPath
{
    JSQMessage *message = [self.messages objectAtIndex:indexPath.item];
    
    if ([message.sender isEqualToString:self.sender]) {
        return nil;
    }
    
    if (indexPath.item - 1 > 0) {
        JSQMessage *previousMessage = [self.messages objectAtIndex:indexPath.item - 1];
        if ([[previousMessage sender] isEqualToString:message.sender]) {
            return nil;
        }
    }
    
    return [[NSAttributedString alloc] initWithString:message.sender];
}

- (NSAttributedString *)collectionView:(JSQMessagesCollectionView *)collectionView attributedTextForCellBottomLabelAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

#pragma mark - UICollectionView DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.messages count];
}

- (UICollectionViewCell *)collectionView:(JSQMessagesCollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    JSQMessagesCollectionViewCell *cell = (JSQMessagesCollectionViewCell *)[super collectionView:collectionView cellForItemAtIndexPath:indexPath];

    JSQMessage *message = [self.messages objectAtIndex:indexPath.item];
    
    if ([message.sender isEqualToString:self.sender]) {
        cell.textView.textColor = [UIColor blackColor];
    }
    else {
        cell.textView.textColor = [UIColor whiteColor];
    }
    
    cell.textView.linkTextAttributes = @{ NSForegroundColorAttributeName : cell.textView.textColor,
                                          NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle | NSUnderlinePatternSolid) };
    
    return cell;
}



#pragma mark - JSQMessages collection view flow layout delegate

- (CGFloat)collectionView:(JSQMessagesCollectionView *)collectionView
                   layout:(JSQMessagesCollectionViewFlowLayout *)collectionViewLayout heightForCellTopLabelAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item % 3 == 0) {
        return kJSQMessagesCollectionViewCellLabelHeightDefault;
    }
    
    return 0.0f;
}

- (CGFloat)collectionView:(JSQMessagesCollectionView *)collectionView
                   layout:(JSQMessagesCollectionViewFlowLayout *)collectionViewLayout heightForMessageBubbleTopLabelAtIndexPath:(NSIndexPath *)indexPath
{
    JSQMessage *currentMessage = [self.messages objectAtIndex:indexPath.item];
    if ([[currentMessage sender] isEqualToString:self.sender]) {
        return 0.0f;
    }
    
    if (indexPath.item - 1 > 0) {
        JSQMessage *previousMessage = [self.messages objectAtIndex:indexPath.item - 1];
        if ([[previousMessage sender] isEqualToString:[currentMessage sender]]) {
            return 0.0f;
        }
    }
    
    return kJSQMessagesCollectionViewCellLabelHeightDefault;
}

- (CGFloat)collectionView:(JSQMessagesCollectionView *)collectionView
                   layout:(JSQMessagesCollectionViewFlowLayout *)collectionViewLayout heightForCellBottomLabelAtIndexPath:(NSIndexPath *)indexPath
{
    return 0.0f;
}

- (void)collectionView:(JSQMessagesCollectionView *)collectionView
                header:(JSQMessagesLoadEarlierHeaderView *)headerView didTapLoadEarlierMessagesButton:(UIButton *)sender
{

}


@end
