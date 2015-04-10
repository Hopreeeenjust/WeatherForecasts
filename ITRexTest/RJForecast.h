//
//  RJForecast.h
//  ITRexTest
//
//  Created by Hopreeeeenjust on 07.04.15.
//  Copyright (c) 2015 Hopreeeeenjust. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MTLModel.h"
#import "MTLJSONAdapter.h"

@class RJLocation;

@interface RJForecast : MTLModel <MTLJSONSerializing>
@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) NSNumber *temperature;
@property (strong, nonatomic) NSNumber *pressure;
@property (strong, nonatomic) NSNumber *humidity;
@property (strong, nonatomic) NSString *weatherType;
@property (strong, nonatomic) NSString *weatherDescription;
@property (strong, nonatomic) NSNumber *cloudness;
@property (strong, nonatomic) NSNumber *windSpeed;
@property (strong, nonatomic) NSNumber *windDirection;
@property (strong, nonatomic) RJLocation *location;
@end
