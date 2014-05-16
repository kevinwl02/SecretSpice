//
//  AppDelegate.m
//  SecretSpice
//
//  Created by Renzo Crisóstomo on 16/05/14.
//  Copyright (c) 2014 UIKonf. All rights reserved.
//

#import "SSPAppDelegate.h"
#import "SSPFoursquareAPIManager.h"

@implementation SSPAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [[SSPFoursquareAPIManager sharedInstance]
     getPlacesWithSearchString:@"Berlin"
     withCompletion:^(NSArray *array, NSError *error) {
         NSLog(@"%@", array);
     }];
    return YES;
}

@end
