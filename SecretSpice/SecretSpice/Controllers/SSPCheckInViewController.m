//
//  SSPCheckInViewController.m
//  SecretSpice
//
//  Created by Renzo Crisóstomo on 16/05/14.
//  Copyright (c) 2014 UIKonf. All rights reserved.
//

#import "SSPCheckInViewController.h"
#import "SSPSecretSpiceAPIManager.h"
#import "SSPChatTableViewController.h"
#import "SSPUserStore.h"
#import "SSPMessagingHelper.h"

@interface SSPCheckInViewController () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation *currentLocation;

- (BOOL)isCurrentLocationValid;
- (void)startCheckIn;
- (void)startConnectionWithCompletionBlock:(BooleanCompletionBlock)completionBlock;

@end

@implementation SSPCheckInViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - Private Methods

- (BOOL)isCurrentLocationValid
{
    if (self.currentLocation == nil) {
        return NO;
    }
    if ([self.currentLocation.timestamp timeIntervalSinceNow] > 5) {
        return NO;
    }
    return YES;
}

- (void)startCheckIn
{
    [SVProgressHUD show];
    [self startConnectionWithCompletionBlock:^(BOOL result, NSError *error) {
        [[SSPSecretSpiceAPIManager sharedInstance]
         checkInWithLocation:self.currentLocation.coordinate
         type:self.sgtCtrlCheckInType.selectedSegmentIndex == 1 ? SSPCheckInType15Min : SSPCheckInType30Min
         andCompletion:^(BOOL result, NSError *error) {
             [SVProgressHUD dismiss];
         }];
    }];
}

- (void)startConnectionWithCompletionBlock:(BooleanCompletionBlock)completionBlock
{
    [SSPUserStore sharedStore].isConnectionToMessagingActive = YES;
    [SSPMessagingHelper startConnectionWithBlock:^(NSString *origin) {
        completionBlock(YES, nil);
    } errorBlock:^(PNError *connectionError) {
        completionBlock(NO, nil);
    }];
}

#pragma mark - Public Methods

- (IBAction)onTouchUpInsideCheckInButton:(id)sender
{
    if ([self isCurrentLocationValid]) {
        [self startCheckIn];
    }
    else {
        self.currentLocation = nil;
        [self.locationManager startUpdatingLocation];
    }
}

- (IBAction)onTouchUpInsideChatsButton:(id)sender
{
    SSPChatTableViewController *viewController = [[SSPChatTableViewController alloc] init];
    [self.navigationController pushViewController:viewController
                                         animated:YES];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager
	 didUpdateLocations:(NSArray *)locations
{
    if (self.currentLocation == nil) {
        [self.locationManager stopUpdatingLocation];
        self.currentLocation = [locations lastObject];
        [self startCheckIn];
    }
}

@end
