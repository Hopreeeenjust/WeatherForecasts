//
//  RJCoordinatesViewController.m
//  ITRexTest
//
//  Created by Hopreeeeenjust on 07.04.15.
//  Copyright (c) 2015 Hopreeeeenjust. All rights reserved.
//

#import "RJCoordinatesViewController.h"
#import "RJServerManager.h"
#import "RJLocation.h"
#import "RJDateViewController.h"

NS_ENUM(NSInteger, RJTextFieldType) {
    RJTextFieldTypeLatitude = 0,
    RJTextFieldTypeLongitude
};

@interface RJCoordinatesViewController () <UITextFieldDelegate>

@end

@implementation RJCoordinatesViewController

#pragma mark - View

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    imageView.image = [UIImage imageNamed:@"Clouds.jpg"];
    [imageView setContentMode:UIViewContentModeScaleAspectFill];
    [self.view addSubview:imageView];
    
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVibrancyEffect *vibrancy = [UIVibrancyEffect effectForBlurEffect:blur];
    
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc]initWithEffect:blur];
    effectView.frame = self.view.frame;

    UIVisualEffectView *vibrantView = [[UIVisualEffectView alloc]initWithEffect:vibrancy];
    effectView.frame = self.view.frame;
    
    [imageView addSubview:effectView];
    [imageView addSubview:vibrantView];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
    self.latitudeField.text = @"";
    self.longitudeField.text = @"";
    [self.latitudeField resignFirstResponder];
    [self.longitudeField resignFirstResponder];

}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

#pragma mark - Actions

- (IBAction)actionShowWeather:(UIButton *)sender {
    if ([self.latitudeField.text isEqualToString:@""] || [self.longitudeField.text isEqualToString:@""]) {
        [self showFillAllFieldsAlert];
    } else {
        RJDateViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"RJDateViewController"];
        vc.lalitude = [self.latitudeField.text floatValue];
        vc.longitude = [self.longitudeField.text floatValue];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSCharacterSet *validationSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789.-"] invertedSet];
    NSArray *components = [string componentsSeparatedByCharactersInSet:validationSet];
    
    if ([components count] > 1) {
        return NO;
    }
    
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    NSArray *validComponents = [newString componentsSeparatedByCharactersInSet:validationSet];
    newString = [validComponents componentsJoinedByString:@""];
    
    if (newString.length > 8) {
        return NO;
    }
    
    if (textField.tag == RJTextFieldTypeLatitude && ([newString floatValue] > 90.f || [newString floatValue]  < -90.f)) {
        return NO;
    } else if (textField.tag == RJTextFieldTypeLongitude && ([newString floatValue] > 180.f || [newString floatValue]  < -180.f)) {
        return NO;
    }
    
    if (![textField.text isEqualToString:@""] && [string isEqualToString:@"-"]) {
        return NO;
    }
    
    if ([[newString componentsSeparatedByString:@"."] count] > 2) {
        return NO;
    }
    
    if ([textField.text isEqualToString:@"0"] && !([string isEqualToString:@"."] || [string isEqualToString:@""])) {
        return NO;
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.tag == RJTextFieldTypeLatitude) {
        return [textField resignFirstResponder] && [self.longitudeField becomeFirstResponder];
    } else if (textField.tag == RJTextFieldTypeLongitude) {
        return [textField resignFirstResponder];
    } else {
        return NO;
    }
}

#pragma mark - Methods 

- (void)showFillAllFieldsAlert {
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"Some fields are not filled" message:@"Please, fill in all the fields" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
    [ac addAction:action];
    [self presentViewController:ac animated:YES completion:nil];
}

@end
