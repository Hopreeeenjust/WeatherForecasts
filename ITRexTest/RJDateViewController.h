//
//  RJDateViewController.h
//  ITRexTest
//
//  Created by Hopreeeeenjust on 08.04.15.
//  Copyright (c) 2015 Hopreeeeenjust. All rights reserved.
//

#import "RJCoreDataTableViewController.h"

@interface RJDateViewController : RJCoreDataTableViewController
@property (assign, nonatomic) CGFloat lalitude;
@property (assign, nonatomic) CGFloat longitude;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end
