//
//  SSPPerson.h
//  SecretSpice
//
//  Created by Renzo Crisóstomo on 16/05/14.
//  Copyright (c) 2014 UIKonf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSPPerson : NSObject

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *channel;
@property (nonatomic, copy, readonly) NSDate *creation;
@property (nonatomic, copy, readonly) NSNumber *checkInType;

+ (SSPPerson *)personWithParseObject:(PFObject *)parseObject;

@end
