//
//  RJLocationData.h
//  ITRexTest
//
//  Created by Hopreeeeenjust on 10.04.15.
//  Copyright (c) 2015 Hopreeeeenjust. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class RJDateData;

@interface RJLocationData : NSManagedObject

@property (nonatomic, retain) NSString * cityName;
@property (nonatomic, retain) NSString * countryIndex;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSNumber * orderNumber;
@property (nonatomic, retain) NSSet *dates;
@end

@interface RJLocationData (CoreDataGeneratedAccessors)

- (void)addDatesObject:(RJDateData *)value;
- (void)removeDatesObject:(RJDateData *)value;
- (void)addDates:(NSSet *)values;
- (void)removeDates:(NSSet *)values;

@end
