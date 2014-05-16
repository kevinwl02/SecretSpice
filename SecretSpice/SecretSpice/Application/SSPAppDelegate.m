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

@implementation SSPAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [self setupMessaging];
    
    // Testing
    [SSPUserStore sharedStore].username = @"Kevin";
    SSPChatTableViewController *chatTableView = [[SSPChatTableViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:chatTableView];
    //SSPChatViewController *chatViewController = [[SSPChatViewController alloc] init];
    self.window.rootViewController = nav;
    
    
    return YES;
}

- (void)setupMessaging {
    
    [PubNub setDelegate:self];
    [SSPMessagingHelper setupConfiguration];
}

#pragma mark - PubNub delegate

- (void)pubnubClient:(PubNub *)client didReceiveMessage:(PNMessage *)message {
    PNLog(PNLogGeneralLevel,self,@"PubNub client received message: %@", message);
}


@end
