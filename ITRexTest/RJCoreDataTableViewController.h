//
//  RJCoreDataTableViewController.h
//  ITRexTest
//
//  Created by Hopreeeeenjust on 07.04.15.
//  Copyright (c) 2015 Hopreeeeenjust. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "RJDataManager.h"

@interface RJCoreDataTableViewController : UIViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
