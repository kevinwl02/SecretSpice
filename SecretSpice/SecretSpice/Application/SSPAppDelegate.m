//
//  AppDelegate.m
//  SecretSpice
//
//  Created by Renzo Crisóstomo on 16/05/14.
//  Copyright (c) 2014 UIKonf. All rights reserved.
//

#import "SSPAppDelegate.h"
#import "PNMacro.h"
#import "SSPMessagingHelper.h"
#import "SSPChatViewController.h"
#import "SSPChatTableViewController.h"
#import "SSPUserStore.h"

@interface SSPAppDelegate ()

- (void)setupMessaging;

@end

@implementation SSPAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Parse setApplicationId:@"BlU8Ak59EUAYRz9TxZ3gz84n9ZslKZl2W6TtuXbf"
                  clientKey:@"pR7It3eiKkpegGeTnPYs4tvmi2qu0h1ecUWBIZ5r"];
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    [self setupMessaging];
    return YES;
}

- (void)setupMessaging {
    
    [PubNub setDelegate:self];
    [SSPMessagingHelper setupConfiguration];
}

#pragma mark - PubNub delegate

- (void)pubnubClient:(PubNub *)client
   didReceiveMessage:(PNMessage *)message {
    PNLog(PNLogGeneralLevel,self,@"PubNub client received message: %@", message);
}


@end
