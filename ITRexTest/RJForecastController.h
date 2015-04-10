//
//  RJForecastControllerViewController.h
//  ITRexTest
//
//  Created by Hopreeeeenjust on 09.04.15.
//  Copyright (c) 2015 Hopreeeeenjust. All rights reserved.
//

#import "RJCoreDataTableViewController.h"

@class RJDateData;

@interface RJForecastController : RJCoreDataTableViewController
@property (weak, nonatomic) IBOutlet UILabel *cityNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) RJDateData *chosenDate;
@end
