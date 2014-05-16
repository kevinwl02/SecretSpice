//
//  SSPPerson.m
//  SecretSpice
//
//  Created by Renzo Crisóstomo on 16/05/14.
//  Copyright (c) 2014 UIKonf. All rights reserved.
//

#import "SSPPerson.h"

@interface SSPPerson ()

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *channel;
@property (nonatomic, copy) NSDate *creation;
@property (nonatomic, copy) NSNumber *checkInType;

@end

@implementation SSPPerson

+ (SSPPerson *)personWithParseObject:(PFObject *)parseObject
{
    SSPPerson *person = [[SSPPerson alloc] init];
    person.name = [parseObject valueForKey:@"userName"];
    person.creation = [parseObject valueForKey:@"createdAt"];
    person.channel = [parseObject valueForKey:@"channel"];
    person.checkInType = [parseObject valueForKey:@"checkInType"];
    return person;
}

@end
