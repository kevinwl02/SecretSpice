//
//  SSPUserStore.h
//  SecretSpice
//
//  Created by Kevin on 16/05/14.
//  Copyright (c) 2014 UIKonf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSPUserStore : NSObject

@property (nonatomic, strong) NSMutableArray *conversations;
@property (nonatomic, assign) BOOL isConnectionToMessagingActive;
@property (nonatomic, strong) NSString *username;

+ (instancetype)sharedStore;

@end
