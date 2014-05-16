//
//  SSPDefinitions.h
//  SecretSpice
//
//  Created by Kevin on 16/05/14.
//  Copyright (c) 2014 UIKonf. All rights reserved.
//

#define SUBSCRIBE_KEY @"sub-c-a5b367b0-dc63-11e3-97df-02ee2ddab7fe"
#define PUBLISH_KEY @"pub-c-f217998d-9a27-4309-b23b-29b34cf7dfa5"
#define SECRET_KEY @"sec-c-MWFmMDM4MDktODYzMy00ZGZmLWI0YTAtOWIyN2VlMWQ5Njg3"
#define CHANNEL_NAME @"org.secretspice.uikonf.testchannel"
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
