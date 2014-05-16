//
//  SSPConversation.m
//  SecretSpice
//
//  Created by Kevin on 16/05/14.
//  Copyright (c) 2014 UIKonf. All rights reserved.
//

#import "SSPConversation.h"

@interface SSPConversation ()

@property (nonatomic, copy) NSString *volunteerName;
@property (nonatomic, strong) PNChannel *channel;
@property (nonatomic, strong) NSMutableArray *messages;

@end

@implementation SSPConversation

- (instancetype)initWithVolunteerName:(NSString *)volunteerName channel:(PNChannel *)channel messages:(NSMutableArray *)messages {
    
    if (self = [super init]){
        
        self.volunteerName = volunteerName;
        self.channel = channel;
        self.messages = messages;
    }
    
    return self;
}

@end
