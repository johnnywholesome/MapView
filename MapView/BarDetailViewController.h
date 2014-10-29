//
//  BarDetailViewController.h
//  MapView
//
//  Created by Jon on 10/22/14.
//  Copyright (c) 2014 Jon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Bar.h"
#import "DirectionsViewController.h"

@interface BarDetailViewController : UIViewController
@property (strong, nonatomic) NSString *barAddress;
@property (nonatomic) CLLocationDegrees currentLatitude;
@property (nonatomic) CLLocationDegrees currentLongitude;
@property (strong, nonatomic) Bar* bar;

@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UITextView *lblSpecial;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress;
@property (weak, nonatomic) IBOutlet UITextView *lblPhone;
@property (weak, nonatomic) IBOutlet UITextView *lblHours;


@end
