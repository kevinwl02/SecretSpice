//
//  SSPMessagingHelper.h
//  SecretSpice
//
//  Created by Kevin on 16/05/14.
//  Copyright (c) 2014 UIKonf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PNStructures.h"

@class PNMessage;
@class PNError;
@class PNChannel;

@interface SSPMessagingHelper : NSObject

+ (PNChannel *)createChannelUserName:(NSString *)username;
+ (void)setupConfiguration;
+ (PNChannel *)subscribeToChannelName: (NSString *)channelName;
+ (void)sendMessage:(id)message ToChannel:(PNChannel *)channel andCompletionBlock:(PNClientMessageProcessingBlock)completionBlock;
+ (void)unsuscribeFromChannel:(PNChannel *)channel;

+ (void)listenToMessagesWithBlock:(void(^)(PNMessage *message))messageBlock;
+ (void)startConnectionWithBlock:(void(^)(NSString *origin))connectionBlock errorBlock:(void(^)(PNError *connectionError))errorBlock;

@end
