//
//  BarDetailViewController.h
//  MapView
//
//  Created by Jon on 10/22/14.
//  Copyright (c) 2014 Jon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Bar.h"

@interface BarDetailViewController : UIViewController
@property (strong, nonatomic) NSString *barName;
@property (strong, nonatomic) NSString *barAddress;
@property (strong, nonatomic) NSString *barSpecial;
@property (strong, nonatomic) NSString *barPhone;
@property (strong, nonatomic) Bar* bar;

@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblSpecial;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress;
@property (weak, nonatomic) IBOutlet UITextView *lblPhone;


@end
