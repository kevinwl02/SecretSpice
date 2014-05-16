//
//  AppDelegate.h
//  SecretSpice
//
//  Created by Renzo Crisóstomo on 16/05/14.
//  Copyright (c) 2014 UIKonf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PubNub/PubNub.h>

@interface SSPAppDelegate : UIResponder <UIApplicationDelegate, PNDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
