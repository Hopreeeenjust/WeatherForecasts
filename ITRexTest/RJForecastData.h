//
//  RJForecastData.h
//  ITRexTest
//
//  Created by Hopreeeeenjust on 10.04.15.
//  Copyright (c) 2015 Hopreeeeenjust. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class RJDateData;

@interface RJForecastData : NSManagedObject

@property (nonatomic, retain) NSNumber * cloudness;
@property (nonatomic, retain) NSNumber * humidity;
@property (nonatomic, retain) NSNumber * pressure;
@property (nonatomic, retain) NSNumber * temperature;
@property (nonatomic, retain) NSString * weatherDescription;
@property (nonatomic, retain) NSString * weatherType;
@property (nonatomic, retain) NSNumber * windDirection;
@property (nonatomic, retain) NSNumber * windSpeed;
@property (nonatomic, retain) NSDate * dateTime;
@property (nonatomic, retain) RJDateData *date;

@end
