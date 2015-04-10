//
//  RJDateData.h
//  ITRexTest
//
//  Created by Hopreeeeenjust on 10.04.15.
//  Copyright (c) 2015 Hopreeeeenjust. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class RJForecastData, RJLocationData;

@interface RJDateData : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSSet *forecasts;
@property (nonatomic, retain) RJLocationData *location;
@end

@interface RJDateData (CoreDataGeneratedAccessors)

- (void)addForecastsObject:(RJForecastData *)value;
- (void)removeForecastsObject:(RJForecastData *)value;
- (void)addForecasts:(NSSet *)values;
- (void)removeForecasts:(NSSet *)values;

@end
