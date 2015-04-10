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

//@implementation RJDateViewController
//@synthesize fetchedResultsController = _fetchedResultsController;
//
//#pragma mark - View
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    
//    [self loadForecastFromServer];
//}
//
//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//}
//
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//}
//
//#pragma mark - NSFetchedResultsController
//
//- (NSFetchedResultsController *)fetchedResultsController
//{
//    if (_fetchedResultsController != nil) {
//        return _fetchedResultsController;
//    }
//    
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//    NSEntityDescription *entity = [NSEntityDescription entityForName:@"RJDateData" inManagedObjectContext:self.managedObjectContext];
//    [fetchRequest setEntity:entity];
//    
//    [fetchRequest setFetchBatchSize:15];
//    
//    NSSortDescriptor *orderSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"location.orderNumber" ascending:NO];
//    NSSortDescriptor *dateSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
//    NSArray *sortDescriptors = @[orderSortDescriptor, dateSortDescriptor];
//    
//    [fetchRequest setSortDescriptors:sortDescriptors];
//    
//    NSFetchedResultsController *aFetchedResultsController =
//    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
//                                        managedObjectContext:self.managedObjectContext
//                                          sectionNameKeyPath:@"location.orderNumber"
//                                                   cacheName:nil];
//    aFetchedResultsController.delegate = self;
//    self.fetchedResultsController = aFetchedResultsController;
//    
//    NSError *error = nil;
//    if (![self.fetchedResultsController performFetch:&error]) {
//        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
//        abort();
//    }
//    
//    return _fetchedResultsController;
//}
//
//#pragma mark - UITableViewDataSource
//
//- (void)configureCell:(RJDateCell *)cell atIndexPath:(NSIndexPath *)indexPath {
//    NSDateFormatter *formatter = [NSDateFormatter new];
//    [formatter setDateFormat:@"dd/MM/yyyy"];
//    RJDateData *date = [self.fetchedResultsController objectAtIndexPath:indexPath];
//    cell.dateLabel.text = [NSString stringWithFormat:@"%@ in %@, %@",[formatter stringFromDate:date.date], date.location.cityName, date.location.countryIndex];
//}
//
//- (RJDateCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *identifier = @"DateCell";
//    RJDateCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//    if (!cell) {
//        cell = [[RJDateCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
//    }
//    [self configureCell:cell atIndexPath:indexPath];
//    return cell;
//}
//
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
//    RJDateData *date = [sectionInfo objects][0];
//    return date.location.cityName;
//}
//
//#pragma mark - UITableViewDelegate
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    RJDateData *date = [self.fetchedResultsController objectAtIndexPath:indexPath];
//    
//    RJForecastController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"RJForecastController"];
//    vc.chosenDate = date;
//    [self.navigationController pushViewController:vc animated:YES];
//}
//
//#pragma mark - Methods
//
//- (void)loadForecastFromServer {
//    UIActivityIndicatorView *view = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    view.center = CGPointMake(CGRectGetMidX(self.view.bounds), 20);
//    [self.tableView addSubview:view];
//    [view startAnimating];
//    
//    [[RJServerManager sharedManager]
//     getWeatherForPlaceWithLatitude:self.lalitude
//     andLongitude:self.longitude
//     onSuccess:^(RJLocation *location) {
//         
//         RJLocationData *currentLocation = [NSEntityDescription insertNewObjectForEntityForName:@"RJLocationData" inManagedObjectContext:self.managedObjectContext];
//         self.dataLocation = currentLocation;
//         
//         [self transformToCoreDataLocation:currentLocation fromServerLocation:location];
//         
//         [[RJDataManager sharedManager] saveContext];
//         [view stopAnimating];
//     } onFailure:^(NSError *error, NSInteger statusCode) {
//         [self showNoConnectionAlert];
//         [view stopAnimating];
//     }];
//}
//
//- (void)showNoConnectionAlert {
//    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"Unable to load data" message:@"The Internet connection appears to be offline" preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Try again" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
//        [self loadForecastFromServer];
//    }];
//    [ac addAction:action];
//    [self presentViewController:ac animated:YES completion:nil];
//}
//
//- (void)transformToCoreDataLocation:(RJLocationData *)dataLocation fromServerLocation:(RJLocation *)serverLocation {
//    dataLocation.cityName = serverLocation.cityName;
//    dataLocation.latitude = serverLocation.latitude;
//    dataLocation.longitude = serverLocation.longitude;
//    dataLocation.countryIndex = serverLocation.countryIndex;
//    dataLocation.dates = [NSSet setWithArray:[self sortAllForecastsByDateFromArray:serverLocation.forecasts]];
//    
//    NSSortDescriptor *orderSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"orderNumber" ascending:NO];
//    NSArray *locationsArray = [self getAllObjectsForEntity:@"RJLocationData" withSortDescriptors:@[orderSortDescriptor]];
//    
//    dataLocation.orderNumber = [NSNumber numberWithInteger:[locationsArray count]];
//    
//}
//
//- (NSArray *)sortAllForecastsByDateFromArray:(NSArray *)forecastsArray {
//    NSString *currentDate = nil;
//    NSMutableArray *tempArray = [NSMutableArray array];
//    NSMutableArray *dateArray = [NSMutableArray array];
//    
//    NSDateFormatter *formatter = [NSDateFormatter new];
//    [formatter setDateFormat:@"dd/MM/yyyy"];
//    [formatter setTimeZone:[NSTimeZone localTimeZone]];
//    
//    RJDateData *date = nil;
//    
//    for (RJForecast *forecast in forecastsArray) {
//        if (![forecast isKindOfClass:[RJForecast class]]) {
//            return nil;
//        }
//        
//        NSString *forecastDate = [formatter stringFromDate:forecast.date];
//        
//        if ([forecastDate isEqualToString:currentDate]) {
//            
//        } else {
//            if (date) {
//                [dateArray removeAllObjects];
//            }
//            date = [NSEntityDescription insertNewObjectForEntityForName:@"RJDateData" inManagedObjectContext:self.managedObjectContext];
//            date.date = forecast.date;
//            date.location = self.dataLocation;
//            currentDate = forecastDate;
//            [tempArray addObject:date];
//        }
//        RJForecastData *dataForecast = [NSEntityDescription insertNewObjectForEntityForName:@"RJForecastData" inManagedObjectContext:self.managedObjectContext];
//        dataForecast.date = date;
//        [self transformToCoreDataForecast:dataForecast fromServerForecast:forecast];
//        [dateArray addObject:dataForecast];
//        date.forecasts = [NSSet setWithArray:dateArray];
//    }
//    return tempArray;
//}
//
//- (void)transformToCoreDataForecast:(RJForecastData *)dataForecat fromServerForecast:(RJForecast *)serverForecast {
//    dataForecat.temperature = serverForecast.temperature;
//    dataForecat.pressure = serverForecast.pressure;
//    dataForecat.humidity = serverForecast.humidity;
//    dataForecat.weatherType = serverForecast.weatherType;
//    dataForecat.weatherDescription = serverForecast.weatherDescription;
//    dataForecat.cloudness = serverForecast.cloudness;
//    dataForecat.windSpeed = serverForecast.windSpeed;
//    dataForecat.windDirection = serverForecast.windDirection;
//    dataForecat.dateTime = serverForecast.date;
//}
//
//- (BOOL)currentLocationDoesExist:(RJLocation *)serverLocation {
//    NSSortDescriptor *orderSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"orderNumber" ascending:NO];
//    NSArray *locationsArray = [self getAllObjectsForEntity:@"RJLocationData" withSortDescriptors:@[orderSortDescriptor]];
//    for (RJLocationData *location in locationsArray) {
//        if ([location.cityName isEqualToString:serverLocation.cityName] && [location.longitude floatValue] == [serverLocation.longitude floatValue] && [location.latitude floatValue] == [serverLocation.latitude floatValue]) {
//            return YES;
//        } else {
//            continue;
//        }
//    }
//    return NO;
//}
//
//- (NSArray *)getAllObjectsForEntity:(NSString *)entityName withSortDescriptors:(NSArray *)descriptors {
//    NSFetchRequest *request = [[NSFetchRequest alloc] init];
//    [request setSortDescriptors:descriptors];
//    NSEntityDescription *description = [NSEntityDescription entityForName:entityName inManagedObjectContext:self.managedObjectContext];
//    [request setEntity:description];
//    NSError *requestError = nil;
//    NSArray *resultArray = [self.managedObjectContext executeFetchRequest:request error:&requestError];
//    return resultArray;
//}
//
//@end
