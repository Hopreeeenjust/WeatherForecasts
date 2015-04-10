//
//  RJForecastCell.h
//  ITRexTest
//
//  Created by Hopreeeeenjust on 09.04.15.
//  Copyright (c) 2015 Hopreeeeenjust. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RJForecastCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *windLabel;
@property (weak, nonatomic) IBOutlet UILabel *cloudnessLabel;
@property (weak, nonatomic) IBOutlet UILabel *humidityLabel;
@property (weak, nonatomic) IBOutlet UILabel *weatherDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *pressureLabel;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImageView;
@end
