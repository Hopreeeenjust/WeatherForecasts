//
//  RJForecastControllerViewController.m
//  ITRexTest
//
//  Created by Hopreeeeenjust on 09.04.15.
//  Copyright (c) 2015 Hopreeeeenjust. All rights reserved.
//

#import "RJForecastController.h"
#import "RJDateData.h"
#import "RJForecastCell.h"
#import "RJForecastData.h"
#import "RJLocationData.h"
#import "UIImageView+AFNetworking.h"

@interface RJForecastController ()
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@end

@implementation RJForecastController
@synthesize fetchedResultsController = _fetchedResultsController;

#pragma mark - View

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    self.dateLabel.text = [formatter stringFromDate:self.chosenDate.date];
    self.cityNameLabel.text = self.chosenDate.location.cityName;
    [self.headerView setFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 59.f)];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - NSFetchedResultsController

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"RJForecastData" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];

    [fetchRequest setFetchBatchSize:20];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"date == %@", self.chosenDate];
    [fetchRequest setPredicate:predicate];
    
    NSSortDescriptor *dateSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"dateTime" ascending:YES];
    NSArray *sortDescriptors = @[dateSortDescriptor];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSFetchedResultsController *aFetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:self.managedObjectContext
                                          sectionNameKeyPath:nil
                                                   cacheName:nil];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _fetchedResultsController;
}

#pragma mark - UITableViewDataSource

- (void)configureCell:(RJForecastCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    RJForecastData *forecast = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.timeLabel.text = [self timeStringFrom:forecast.dateTime];
    cell.temperatureLabel.text = [NSString stringWithFormat:@"Temp: %@%.1f °C", [forecast.temperature floatValue] > 0 ? @"+" : @"", [forecast.temperature floatValue]];
    cell.windLabel.text = [self windTextFromWindSpeed:forecast.windSpeed andDirection:forecast.windDirection];
    cell.humidityLabel.text = [NSString stringWithFormat:@"Humidity: %ld%%", [forecast.humidity integerValue]];
    cell.pressureLabel.text = [NSString stringWithFormat:@"Pressure: %ld hP", [forecast.pressure integerValue]];
    cell.cloudnessLabel.text = [NSString stringWithFormat:@"Cloudness: %ld%%", [forecast.cloudness integerValue]];
    cell.weatherDescriptionLabel.text = [NSString stringWithFormat:@"Weather description: %@", forecast.weatherDescription];
    
    NSString *stringURL = [self chooseImageURLDueToWeatherType:forecast.weatherType];
    NSURL *imageURL = [NSURL URLWithString:stringURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:imageURL];
    cell.weatherImageView.image = nil;
    __weak RJForecastCell *weakCell = cell;
    [cell.weatherImageView setImageWithURLRequest:request
                          placeholderImage:nil
                                   success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                       weakCell.weatherImageView.image = image;
                                       [weakCell layoutSubviews];
                                   }
                                   failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                       NSLog(@"Error = %@, code = %ld", [error localizedDescription], response.statusCode);
                                   }];

}

- (RJForecastCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"RJForecastCell";
    RJForecastCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[RJForecastCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.f;
}

#pragma mark - Methods

- (NSString *)timeStringFrom:(NSDate *)date {
    NSDateFormatter *timeFormatter = [NSDateFormatter new];
    [timeFormatter setDateFormat:@"HH:mm"];
    NSString *time = [timeFormatter stringFromDate:date];
    return time;
}

- (NSString *)windTextFromWindSpeed:(NSNumber *)speed andDirection:(NSNumber *)direction {
    NSString *speedString = [NSString stringWithFormat:@"%.1f", [speed floatValue]];

    NSString *directionString;
    if ([direction floatValue] > 337.5f) {
        directionString = @"north";
    } else if ([direction floatValue] > 292.5f) {
        directionString = @"north/east";
    } else if ([direction floatValue] > 247.5f) {
        directionString = @"east";
    } else if ([direction floatValue] > 202.5f) {
        directionString = @"south/east";
    } else if ([direction floatValue] > 157.5f) {
        directionString = @"south";
    } else if ([direction floatValue] > 112.5f) {
        directionString = @"south/west";
    } else if ([direction floatValue] > 67.5f) {
        directionString = @"west";
    } else if ([direction floatValue] > 22.5f) {
        directionString = @"north/west";
    } else {
        directionString = @"north";
    }
    return [NSString stringWithFormat:@"Wind: %@ m/s (%@)", speedString, directionString];
}

- (NSString *)chooseImageURLDueToWeatherType:(NSString *)weatherType {
    NSString *imageURL;
    if ([weatherType isEqualToString:@"Rain"]) {
        imageURL = @"https://ssl.gstatic.com/onebox/weather/256/rain.png";
    } else if ([weatherType isEqualToString:@"Sunny"] || [weatherType isEqualToString:@"Clear"]) {
        imageURL = @"https://ssl.gstatic.com/onebox/weather/256/sunny.png";
    } else if ([weatherType isEqualToString:@"Clouds"]) {
        imageURL = @"https://ssl.gstatic.com/onebox/weather/256/cloudy.png";
    } else {
        imageURL = nil;
    }
    return imageURL;
}


@end
