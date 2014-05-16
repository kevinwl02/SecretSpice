//
//  SSPSecretSpiceAPIManager.m
//  SecretSpice
//
//  Created by Renzo Crisóstomo on 16/05/14.
//  Copyright (c) 2014 UIKonf. All rights reserved.
//

#import "SSPSecretSpiceAPIManager.h"

@implementation SSPSecretSpiceAPIManager

#pragma mark - Public Methods

+ (instancetype)sharedInstance
{
    static dispatch_once_t dispatchOnce;
    static SSPSecretSpiceAPIManager *manager = nil;
    dispatch_once(&dispatchOnce, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (void)checkInWithLocation:(CLLocationCoordinate2D)location
                       type:(SSPCheckInType)checkInType
              andCompletion:(BooleanCompletionBlock)completionBlock
{
    PFObject *activeSession = [PFObject objectWithClassName:@"ActiveSession"];
    activeSession[@"userName"] = USER_NAME;
    activeSession[@"latitude"] = [NSNumber numberWithDouble:location.latitude];
    activeSession[@"longitude"] = [NSNumber numberWithDouble:location.longitude];
    activeSession[@"channel"] = CHANNEL;
    activeSession[@"checkInType"] = [NSNumber numberWithInt:checkInType];
    [activeSession saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        completionBlock(succeeded, error);
    }];
}

@end
