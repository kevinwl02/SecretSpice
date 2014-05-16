//
//  SSPConversation.h
//  SecretSpice
//
//  Created by Kevin on 16/05/14.
//  Copyright (c) 2014 UIKonf. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PNChannel;

@interface SSPConversation : NSObject

@property (nonatomic, copy, readonly) NSString *volunteerName;
@property (nonatomic, strong, readonly) PNChannel *channel;
@property (nonatomic, strong, readonly) NSMutableArray *messages;

- (instancetype)initWithVolunteerName:(NSString *)volunteerName channel:(PNChannel *)channel messages:(NSMutableArray *)messages;

@end
