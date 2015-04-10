//
//  RJServerManager.m
//  ITRexTest
//
//  Created by Hopreeeeenjust on 07.04.15.
//  Copyright (c) 2015 Hopreeeeenjust. All rights reserved.
//

#import "RJServerManager.h"
#import "AFHTTPRequestOperationManager.h"
#import "MTLJSONAdapter.h"
#import "RJForecast.h"
#import "RJLocation.h"

@interface RJServerManager ()
@property (strong, nonatomic) AFHTTPRequestOperationManager *requestOperationManager;
@end

static const NSString *key = @"abdbdc896de22f96e2a7278bc641e15c";

@implementation RJServerManager

+ (RJServerManager *)sharedManager {
    static RJServerManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [RJServerManager new];
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSString *urlString = @"http://api.openweathermap.org/";
        NSURL *url = [NSURL URLWithString:urlString];
        self.requestOperationManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:url];
    }
    return self;
}

- (void) getWeatherForPlaceWithLatitude:(CGFloat)latitude andLongitude:(CGFloat)longitude
                              onSuccess:(void(^)(RJLocation *location))success
                              onFailure:(void(^)(NSError *error, NSInteger statusCode))failure {
    NSDictionary *parameters = @{
                                 @"lat": @(latitude),
                                 @"lon": @(longitude),
                                 @"APPID": key};
    
    [self.requestOperationManager GET:@"data/2.5/forecast"
                           parameters:parameters
                              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                  if (responseObject) {
                                      [self deserializeLocationFromJSON:responseObject onSuccess:^(RJLocation *location) {
                                          success(location);
                                      } onFailure:^(NSError *error) {
                                          failure(error, error.code);
                                      }];
                                  }
                              }
                              failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                  failure(error, error.code);
                              }];
}

#pragma mark - Methods

- (void)deserializeLocationFromJSON:(NSDictionary *)locationJSON
                       onSuccess:(void(^)(RJLocation *location)) success
                       onFailure:(void(^)(NSError* error)) failure {
    NSError *error;
    RJLocation *location = [MTLJSONAdapter modelOfClass:[RJLocation class] fromJSONDictionary:locationJSON error:&error];

    if (error) {
        failure(error);
    } else if (location) {
        success(location);
    }
}


@end
