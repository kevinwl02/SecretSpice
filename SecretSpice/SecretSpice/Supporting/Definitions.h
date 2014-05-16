//
//  Definitions.h
//  SecretSpice
//
//  Created by Renzo Crisóstomo on 16/05/14.
//  Copyright (c) 2014 UIKonf. All rights reserved.
//

#define BASE_URL @"https://api.foursquare.com/v2"
#define CLIENT_ID @"JFDBI5SDZCMSYM2BOGBL4RMINZK33OVH2NXN4RMG323NLD4V"
#define CLIENT_SECRET @"4QXEULC5W4UFXCJGU5JV2G0KYNJ5YHBANHMTFCSRJ5VFNZEA"
#define USER_NAME @"Renzo Crisóstomo"
#define CHANNEL @"TEST_CHANNEL_1"

typedef void (^ArrayCompletionBlock)(NSArray *array, NSError *error);

typedef void (^BooleanCompletionBlock)(BOOL result, NSError *error);

typedef NS_ENUM(NSUInteger, SSPCheckInType) {
    SSPCheckInTypeNone,
    SSPCheckInType15Min,
    SSPCheckInType30Min
};
