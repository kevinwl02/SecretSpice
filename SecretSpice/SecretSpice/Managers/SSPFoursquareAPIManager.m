//
//  SSPFoursquareAPIManager.m
//  SecretSpice
//
//  Created by Renzo Crisóstomo on 16/05/14.
//  Copyright (c) 2014 UIKonf. All rights reserved.
//

#import "SSPFoursquareAPIManager.h"
#import "SSPPlace.h"

@interface SSPFoursquareAPIManager ()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;

- (NSString *)getVersion;

@end

@implementation SSPFoursquareAPIManager

#pragma mark - Private Methods

- (AFHTTPSessionManager *)sessionManager
{
    if (_sessionManager == nil) {
        _sessionManager = [[AFHTTPSessionManager alloc]
                           initWithBaseURL:[NSURL URLWithString:BASE_URL]];
        [_sessionManager setResponseSerializer:[AFJSONResponseSerializer serializer]];
    }
    return _sessionManager;
}

- (NSDateFormatter *)dateFormatter
{
    if (_dateFormatter == nil) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateFormat:@"YYYYMMDD"];
    }
    return _dateFormatter;
}

- (NSString *)getVersion
{
    return [[self dateFormatter] stringFromDate:[NSDate date]];
}

- (id)translatePlaces:(NSArray *)places
{
    NSMutableArray *collection = [NSMutableArray array];
    for (NSDictionary *place in places) {
        id model = [MTLJSONAdapter modelOfClass:[SSPPlace class]
                             fromJSONDictionary:place
                                          error:nil];
        [collection addObject:model];
    }
    return [collection copy];

}

#pragma mark - Public Methods

+ (instancetype)sharedInstance
{
    static dispatch_once_t dispatchOnce;
    static SSPFoursquareAPIManager *manager = nil;
    dispatch_once(&dispatchOnce, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (void)getPlacesWithSearchString:(NSString *)searchString
                   withCompletion:(ArrayCompletionBlock)completionBlock
{
    [[self sessionManager] GET:@"venues/search"
                    parameters:@{
                                 @"client_id": CLIENT_ID,
                                 @"client_secret": CLIENT_SECRET,
                                 @"v": [self getVersion],
                                 @"near": searchString
                                }
                       success:^(NSURLSessionDataTask *task, id responseObject) {
                           NSDictionary *response = [responseObject objectForKey:@"response"];
                           NSArray *venues = [response objectForKey:@"venues"];
                           completionBlock([self translatePlaces:venues], nil);
                       }
                       failure:^(NSURLSessionDataTask *task, NSError *error) {
                           completionBlock(nil, error);
                       }];
}

@end
