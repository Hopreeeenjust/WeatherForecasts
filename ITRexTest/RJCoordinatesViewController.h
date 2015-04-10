//
//  RJCoordinatesViewController.h
//  ITRexTest
//
//  Created by Hopreeeeenjust on 07.04.15.
//  Copyright (c) 2015 Hopreeeeenjust. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RJCoordinatesViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *latitudeField;
@property (weak, nonatomic) IBOutlet UITextField *longitudeField;
@property (weak, nonatomic) IBOutlet UIButton *showButton;

- (IBAction)actionShowWeather:(id)sender;
@end
