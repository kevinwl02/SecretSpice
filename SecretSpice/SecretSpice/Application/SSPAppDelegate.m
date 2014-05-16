//
//  AppDelegate.m
//  SecretSpice
//
//  Created by Renzo Crisóstomo on 16/05/14.
//  Copyright (c) 2014 UIKonf. All rights reserved.
//

#import "SSPAppDelegate.h"
#import "PNMacro.h"
#import "SSPMessagingHelper.h"
#import "SSPChatViewController.h"
#import "SSPChatTableViewController.h"
#import "SSPUserStore.h"
#import "PNMessage.h"
#import "SSPConversation.h"
#import "JSQMessage.h"
#import "PNChannel.h"

@interface SSPAppDelegate ()

- (void)setupMessaging;

@end

@implementation SSPAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Parse setApplicationId:@"BlU8Ak59EUAYRz9TxZ3gz84n9ZslKZl2W6TtuXbf"
                  clientKey:@"pR7It3eiKkpegGeTnPYs4tvmi2qu0h1ecUWBIZ5r"];
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    [self setupMessaging];
    return YES;
}

- (void)setupMessaging {
    
    [PubNub setDelegate:self];
    [SSPMessagingHelper setupConfiguration];
}

#pragma mark - PubNub delegate

- (void)pubnubClient:(PubNub *)client
   didReceiveMessage:(PNMessage *)message {
    PNLog(PNLogGeneralLevel,self,@"PubNub client received message: %@", message);
    
    NSDictionary *messageDataDictionary = message.message;
    NSString *sender = [messageDataDictionary valueForKey:@"sender"];
    NSString *messageText = [messageDataDictionary valueForKey:@"message"];
    NSString *activeUsername = USER_NAME;
    PNChannel *ownChannel = [SSPUserStore sharedStore].ownChannel;
    
    if ([[ownChannel name] isEqualToString:message.channel.name]
        && ![[SSPUserStore sharedStore] received]) {
        JSQMessage *message = [[JSQMessage alloc] initWithText:messageText
                                                        sender:sender
                                                          date:[NSDate date]];
        SSPConversation *conversation = [[SSPConversation alloc]
                                         initWithVolunteerName:activeUsername
                                         channel:ownChannel
                                         messages:@[message].mutableCopy];
        [[[SSPUserStore sharedStore] conversations] addObject:conversation];
        [[SSPUserStore sharedStore] setReceived:YES];
        [TSMessage showNotificationWithTitle:[NSString stringWithFormat:@"Message from %@", sender]
                                    subtitle:messageText
                                        type:TSMessageNotificationTypeMessage];
    }
    
}


@end
