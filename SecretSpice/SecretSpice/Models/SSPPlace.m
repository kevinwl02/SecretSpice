//
//  SSPPlace.m
//  SecretSpice
//
//  Created by Renzo Crisóstomo on 16/05/14.
//  Copyright (c) 2014 UIKonf. All rights reserved.
//

#import "SSPPlace.h"

@implementation SSPPlace

#pragma mark - MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"name": @"name",
             @"address": @"location.address",
             @"latitude": @"location.lat",
             @"longitude": @"location.lng"
            };
}

@end
