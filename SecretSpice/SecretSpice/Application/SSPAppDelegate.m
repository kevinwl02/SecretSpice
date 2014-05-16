//
//  AppDelegate.m
//  SecretSpice
//
//  Created by Renzo Crisóstomo on 16/05/14.
//  Copyright (c) 2014 UIKonf. All rights reserved.
//

#import "SSPAppDelegate.h"

@implementation SSPAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Parse setApplicationId:@"BlU8Ak59EUAYRz9TxZ3gz84n9ZslKZl2W6TtuXbf"
                  clientKey:@"pR7It3eiKkpegGeTnPYs4tvmi2qu0h1ecUWBIZ5r"];
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    return YES;
}

@end
