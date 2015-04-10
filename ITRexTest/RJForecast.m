//
//  RJForecast.m
//  ITRexTest
//
//  Created by Hopreeeeenjust on 07.04.15.
//  Copyright (c) 2015 Hopreeeeenjust. All rights reserved.
//

#import "RJForecast.h"
#import "MTLValueTransformer.h"
#import "NSValueTransformer+MTLPredefinedTransformerAdditions.h"

@implementation RJForecast

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"date": @"dt",
             @"temperature": @"main.temp",
             @"pressure": @"main.pressure",
             @"humidity": @"main.humidity",
             @"weatherType": @"weather.main",
             @"weatherDescription": @"weather.description",
             @"cloudness": @"clouds.all",
             @"windSpeed": @"wind.speed",
             @"windDirection": @"wind.deg",
             @"location": NSNull.null
             };
}

+ (NSValueTransformer *)dateJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithBlock:^(NSString *string) {
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[string integerValue]];
        return date;
    }];
}

+ (NSValueTransformer *)temperatureJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithBlock:^(NSString *string) {
        return [NSNumber numberWithFloat:([string floatValue] - 273.15f)];
    }];
}

+ (NSValueTransformer *)pressureJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithBlock:^(NSString *string) {
        return [NSNumber numberWithInteger:([string integerValue])];
    }];
}

+ (NSValueTransformer *)humidityJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithBlock:^(NSString *string) {
        return [NSNumber numberWithInteger:([string integerValue])];
    }];
}

+ (NSValueTransformer *)cloudnessJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithBlock:^(NSString *string) {
        return [NSNumber numberWithInteger:([string integerValue])];
    }];
}

+ (NSValueTransformer *)windSpeedJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithBlock:^(NSString *string) {
        return [NSNumber numberWithFloat:([string floatValue] * 3.6f)];
    }];
}

+ (NSValueTransformer *)windDirectionJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithBlock:^(NSString *string) {
        return [NSNumber numberWithFloat:[string floatValue]];
    }];
}

+ (NSValueTransformer *)weatherTypeJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithBlock:^(NSArray *array) {
        return [array firstObject];
    }];
}

+ (NSValueTransformer *)weatherDescriptionJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithBlock:^(NSArray *array) {
        return [array firstObject];
    }];
}

@end
