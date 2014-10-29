//
//  DirectionsViewController.h
//  MapView
//
//  Created by Jon on 10/23/14.
//  Copyright (c) 2014 Jon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Bar.h"

@interface DirectionsViewController : UIViewController
@property (nonatomic) CLLocationDegrees currentLatitude;
@property (nonatomic) CLLocationDegrees currentLongitude;
@property (strong, nonatomic) Bar * bar;
@property (strong, nonatomic) NSString *urlString;
@property (strong, nonatomic) NSURL *gMapUrl;

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
