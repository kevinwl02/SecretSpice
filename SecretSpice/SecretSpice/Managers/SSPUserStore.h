//
//  SSPUserStore.h
//  SecretSpice
//
//  Created by Kevin on 16/05/14.
//  Copyright (c) 2014 UIKonf. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PNChannel;
@class SSPConversation;

@interface SSPUserStore : NSObject

@property (nonatomic, strong) NSMutableArray *conversations;
@property (nonatomic, assign) BOOL isConnectionToMessagingActive;
@property (nonatomic, strong) NSString *username;

@property (nonatomic, strong) PNChannel *ownChannel;
@property (nonatomic, strong) SSPConversation *ownConversation;

+ (instancetype)sharedStore;

@end
