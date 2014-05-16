//
//  SSPSecretSpiceAPIManager.m
//  SecretSpice
//
//  Created by Renzo Crisóstomo on 16/05/14.
//  Copyright (c) 2014 UIKonf. All rights reserved.
//

#import "SSPSecretSpiceAPIManager.h"
#import "SSPPerson.h"
#import "SSPPlace.h"
#import "SSPMessagingHelper.h"
#import "PNChannel.h"
#import "SSPUserStore.h"

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
    PNChannel *channel = [SSPMessagingHelper createChannelUserName:USER_NAME];
    [SSPUserStore sharedStore].ownChannel = channel;
    
    PFObject *activeSession = [PFObject objectWithClassName:@"ActiveSession"];
    activeSession[@"userName"] = USER_NAME;
    activeSession[@"latitude"] = [NSNumber numberWithDouble:location.latitude];
    activeSession[@"longitude"] = [NSNumber numberWithDouble:location.longitude];
    activeSession[@"channel"] = channel.name;
    activeSession[@"checkInType"] = [NSNumber numberWithInt:checkInType];
    [activeSession saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        completionBlock(succeeded, error);
    }];
}

- (void)getPeopleWithPlace:(SSPPlace *)place
                completion:(ArrayCompletionBlock)completionBlock
{
    /*
     TODO: Send place information to service.
     */
    PFQuery *query = [PFQuery queryWithClassName:@"ActiveSession"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            NSMutableArray *people = [NSMutableArray array];
            for (PFObject *parseObject in objects) {
                NSString *name = [parseObject valueForKey:@"name"];
                if (![name isEqualToString:USER_NAME]) {
                    [people addObject:[SSPPerson personWithParseObject:parseObject]];
                }
            }
            completionBlock([people copy], nil);
        } else {
            completionBlock(nil, error);
        }
    }];
}

@end
