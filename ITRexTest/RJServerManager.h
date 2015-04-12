//
//  RJServerManager.h
//  ITRexTest
//
//  Created by Hopreeeeenjust on 07.04.15.
//  Copyright (c) 2015 Hopreeeeenjust. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class RJLocation;

@interface RJServerManager : NSObject

+ (RJServerManager *)sharedManager;

- (void) getWeatherForPlaceWithLatitude:(CGFloat)latitude andLongitude:(CGFloat)longitude
                              onSuccess:(void(^)(RJLocation *location))success
                              onFailure:(void(^)(NSError *error, NSInteger statusCode))failure;

@end

