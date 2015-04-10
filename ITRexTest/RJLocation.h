//
//  RJLocation.h
//  ITRexTest
//
//  Created by Hopreeeeenjust on 08.04.15.
//  Copyright (c) 2015 Hopreeeeenjust. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTLModel.h"
#import "MTLJSONAdapter.h"

@interface RJLocation : MTLModel <MTLJSONSerializing>
@property (strong, nonatomic) NSString *cityName;
@property (strong, nonatomic) NSNumber *latitude;
@property (strong, nonatomic) NSNumber *longitude;
@property (strong, nonatomic) NSString *countryIndex;
@property (strong, nonatomic) NSArray *forecasts;
@end
