//
//  SSPCheckInViewController.h
//  SecretSpice
//
//  Created by Renzo Crisóstomo on 16/05/14.
//  Copyright (c) 2014 UIKonf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSPCheckInViewController : UIViewController

@property (nonatomic, weak) IBOutlet UISegmentedControl *sgtCtrlCheckInType;

- (IBAction)onTouchUpInsideCheckInButton:(id)sender;

@end
