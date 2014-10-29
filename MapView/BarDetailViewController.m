//
//  BarDetailViewController.m
//  MapView
//
//  Created by Jon on 10/22/14.
//  Copyright (c) 2014 Jon. All rights reserved.
//

#import "BarDetailViewController.h"

@interface BarDetailViewController ()

@end

@implementation BarDetailViewController
@synthesize barAddress, bar, currentLatitude, currentLongitude;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setBarAddress:[NSString stringWithFormat:@"%@\n%@, %@, %@", self.bar.street, self.bar.city, self.bar.state, self.bar.zip]];
    
    
    self.lblName.text = self.bar.name;
    self.lblAddress.text = self.barAddress;
    self.lblPhone.text = self.bar.phone;
    self.lblSpecial.text = self.bar.special;
    self.lblHours.text = self.bar.hours;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    DirectionsViewController *dvc = [segue destinationViewController];
    [dvc setBar:self.bar];
    [dvc setCurrentLatitude:self.currentLatitude];
    [dvc setCurrentLongitude:self.currentLongitude];
    [dvc setTitle:@"Happy Trails!"];
}


@end
