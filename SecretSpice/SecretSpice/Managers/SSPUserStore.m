//
//  SSPUserStore.m
//  SecretSpice
//
//  Created by Kevin on 16/05/14.
//  Copyright (c) 2014 UIKonf. All rights reserved.
//

#import "SSPUserStore.h"

@implementation SSPUserStore

+ (instancetype)sharedStore {
    
    static SSPUserStore *userStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userStore = [[SSPUserStore alloc] init];
    });
    
    return userStore;
}

- (NSMutableArray *)conversations {
    
    if (!_conversations)
        _conversations = [[NSMutableArray alloc] init];
    
    return _conversations;
}

@end
