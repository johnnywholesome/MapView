//
//  DirectionsViewController.m
//  MapView
//
//  Created by Jon on 10/23/14.
//  Copyright (c) 2014 Jon. All rights reserved.
//

#import "DirectionsViewController.h"

@interface DirectionsViewController ()

@end

@implementation DirectionsViewController
@synthesize webView, gMapUrl, urlString, currentLongitude, currentLatitude;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *googleMapsURLString = [NSString stringWithFormat:@"http://maps.google.com/?saddr=%1.6f,%1.6f&daddr=%1.6f,%1.6f&directionsmode=transit",
                                     self.currentLatitude, self.currentLongitude, self.bar.lat, self.bar.lng];
    
   self.gMapUrl = [[NSURL alloc]initWithString:googleMapsURLString];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:gMapUrl];
    [webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
