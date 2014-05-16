//
//  SSPMessagingHelper.m
//  SecretSpice
//
//  Created by Kevin on 16/05/14.
//  Copyright (c) 2014 UIKonf. All rights reserved.
//

#import "SSPMessagingHelper.h"
#import <PubNub/PubNub.h>
#import "PNChannel.h"
#import "PNConfiguration.h"
#import "PNObservationCenter.h"
#import "PNError.h"
#import "PNMessage.h"

@implementation SSPMessagingHelper

+ (PNChannel *)createChannelUserName:(NSString *)username {
    
    NSString *channelName = [NSString stringWithFormat:@"%@.%@", username, CHANNEL_NAME];
    PNChannel *channel = [self subscribeToChannelName:channelName];
    
    return channel;
}

+ (void)setupConfiguration {
    
    PNConfiguration *configuration = [PNConfiguration configurationWithPublishKey:PUBLISH_KEY
                                                                     subscribeKey:SUBSCRIBE_KEY
                                                                        secretKey:SECRET_KEY];
    [PubNub setConfiguration:configuration];
}

+ (PNChannel *)subscribeToChannelName: (NSString *)channelName {
    
    PNChannel *channel = [PNChannel channelWithName:channelName];
    [PubNub subscribeOnChannel:channel];
    
    return channel;
}

+ (void)sendMessage:(id)message ToChannel:(PNChannel *)channel andCompletionBlock:(PNClientMessageProcessingBlock)completionBlock {
    
    [PubNub sendMessage:message toChannel:channel withCompletionBlock:completionBlock];
}

+ (void)unsuscribeFromChannel:(PNChannel *)channel {
    
    [PubNub unsubscribeFromChannel:channel];
}

+ (void)listenToMessagesWithBlock:(void(^)(PNMessage *message))messageBlock {
    
    static PNClientMessageHandlingBlock viewNotificationBlock = nil;
    viewNotificationBlock = messageBlock;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [[PNObservationCenter defaultCenter] addMessageReceiveObserver:self withBlock:^(PNMessage *message) {
            
            viewNotificationBlock (message);
        }];
    });
}

+ (void)startConnectionWithBlock:(void(^)(NSString *origin))connectionBlock errorBlock:(void(^)(PNError *connectionError))errorBlock {
    
    [PubNub connectWithSuccessBlock:connectionBlock errorBlock:errorBlock];
}

@end
