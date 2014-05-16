//
//  SSPChatTableViewController.m
//  SecretSpice
//
//  Created by Kevin on 16/05/14.
//  Copyright (c) 2014 UIKonf. All rights reserved.
//

#import "SSPChatTableViewController.h"
#import "SSPUserStore.h"
#import "SSPConversation.h"
#import "SSPChatViewController.h"

@interface SSPChatTableViewController ()

@property (nonatomic, strong) NSMutableArray *conversations;

@end

@implementation SSPChatTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.conversations = [SSPUserStore sharedStore].conversations;
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.conversations.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ConversationCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ConversationCell"];
    }
    
    // Configure the cell...
    SSPConversation *conversation = [self.conversations objectAtIndex:indexPath.row];
    
    cell.textLabel.text = conversation.volunteerName;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SSPConversation *conversation = [self.conversations objectAtIndex:indexPath.row];
    SSPChatViewController *chatViewController = [[SSPChatViewController alloc]
                                                 initWithConversation:conversation];
    [self.navigationController pushViewController:chatViewController animated:YES];
}

@end
