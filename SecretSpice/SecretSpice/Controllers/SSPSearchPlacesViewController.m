//
//  SSPSearchPlacesViewController.m
//  SecretSpice
//
//  Created by Renzo Crisóstomo on 16/05/14.
//  Copyright (c) 2014 UIKonf. All rights reserved.
//

#import "SSPSearchPlacesViewController.h"
#import "SSPFoursquareAPIManager.h"
#import "SSPPlace.h"
#import "SSPPlaceViewController.h"

@interface SSPSearchPlacesViewController () <UISearchBarDelegate>

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation SSPSearchPlacesViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"PlaceSegue"]) {
        SSPPlaceViewController *viewController = [segue destinationViewController];
        SSPPlace *place = self.dataSource[self.tableView.indexPathForSelectedRow.row];
        [viewController setPlace:place];
    }
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
    static NSString *CellIdentifier = @"PlaceCell";
    UITableViewCell *cell = [[self tableView] dequeueReusableCellWithIdentifier:CellIdentifier
                                                               forIndexPath:indexPath];
    SSPPlace *place = self.dataSource[indexPath.row];
    [cell.textLabel setText:place.name];
    [cell.detailTextLabel setText:place.address];
    return cell;
}

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    @weakify(self);
    
    [SVProgressHUD show];
    [[SSPFoursquareAPIManager sharedInstance]
     getPlacesWithSearchString:searchBar.text
     withCompletion:^(NSArray *array, NSError *error) {
         
         @strongify(self);
         
         dispatch_async(dispatch_get_main_queue(), ^{
             [SVProgressHUD dismiss];
             [[self dataSource] removeAllObjects];
             [[self dataSource] addObjectsFromArray:array];
             [[self tableView] reloadData];
             [self.searchDisplayController setActive:NO
                                            animated:YES];
         });
     }];
}

#pragma mark - UISearchDisplayDelegate

- (void)searchDisplayController:(UISearchDisplayController *)controller
 willShowSearchResultsTableView:(UITableView *)tableView
{
    for(UIView *subview in tableView.subviews) {
        if([subview class] == [UILabel class]) {
            UILabel *displayLabel = (UILabel *)subview;
            displayLabel.text = @"";
        }
    }
}

@end
