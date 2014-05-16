//
//  SSPSecretSpiceAPIManager.h
//  SecretSpice
//
//  Created by Renzo Crisóstomo on 16/05/14.
//  Copyright (c) 2014 UIKonf. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SSPPlace;

@interface SSPSecretSpiceAPIManager : NSObject

+ (instancetype)sharedInstance;
- (void)checkInWithLocation:(CLLocationCoordinate2D)location
                       type:(SSPCheckInType)checkInType
              andCompletion:(BooleanCompletionBlock)completionBlock;
- (void)getPeopleWithPlace:(SSPPlace *)place
                completion:(ArrayCompletionBlock)completionBlock;

@end
