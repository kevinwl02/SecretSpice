//
//  SSPPeopleViewController.m
//  SecretSpice
//
//  Created by Renzo Crisóstomo on 16/05/14.
//  Copyright (c) 2014 UIKonf. All rights reserved.
//

#import "SSPPeopleViewController.h"
#import "SSPSecretSpiceAPIManager.h"
#import "SSPPlace.h"
#import "SSPPerson.h"
#import "SSPChatViewController.h"

@interface SSPPeopleViewController ()

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation SSPPeopleViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    @weakify(self);
    
    [super viewDidLoad];
    [SVProgressHUD show];
    [[SSPSecretSpiceAPIManager sharedInstance]
     getPeopleWithPlace:self.place
     completion:^(NSArray *array, NSError *error) {
         
         @strongify(self);
         
         dispatch_async(dispatch_get_main_queue(), ^{
             [SVProgressHUD dismiss];
             [[self dataSource] removeAllObjects];
             [[self dataSource] addObjectsFromArray:array];
             [[self tableView] reloadData];
         });
     }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *CellIdentifier = @"PersonCell";
    UITableViewCell *cell = [[self tableView] dequeueReusableCellWithIdentifier:CellIdentifier
                                                                   forIndexPath:indexPath];
    SSPPerson *person = self.dataSource[indexPath.row];
    [cell.textLabel setText:person.name];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SSPPerson *person = self.dataSource[indexPath.row];
    SSPChatViewController *viewController = [[SSPChatViewController alloc]
                                             initWithSelectedVolunteer:person];
    [self.navigationController pushViewController:viewController
                                         animated:YES];
}

@end
