//
//  SSPChatViewController.h
//  SecretSpice
//
//  Created by Kevin on 16/05/14.
//  Copyright (c) 2014 UIKonf. All rights reserved.
//

#import "JSQMessagesViewController.h"

@class PNChannel;
@class SSPConversation;
@class SSPPerson;

@interface SSPChatViewController : JSQMessagesViewController

- (instancetype)initWithSelectedVolunteer:(SSPPerson *)volunteer;
- (instancetype)initWithConversation:(SSPConversation *)conversation;

@end
