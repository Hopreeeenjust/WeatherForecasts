//
//  RJLocation.m
//  ITRexTest
//
//  Created by Hopreeeeenjust on 08.04.15.
//  Copyright (c) 2015 Hopreeeeenjust. All rights reserved.
//

#import "RJLocation.h"
#import "MTLValueTransformer.h"
#import "NSValueTransformer+MTLPredefinedTransformerAdditions.h"
#import "RJForecast.h"

@implementation RJLocation

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"cityName": @"city.name",
             @"latitude": @"city.coord.lat",
             @"longitude": @"city.coord.lon",
             @"countryIndex": @"city.country",
             @"forecasts": @"list"
             };
}

+ (NSValueTransformer *)latitudeJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithBlock:^(NSString *string) {
        return [NSNumber numberWithInteger:[string floatValue]];
    }];
}

+ (NSValueTransformer *)longitudeJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithBlock:^(NSString *string) {
        return [NSNumber numberWithInteger:[string floatValue]];
    }];
}

+ (NSValueTransformer *)forecastsJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[RJForecast class]];
}

@end
