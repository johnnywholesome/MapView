//
//  ViewController.h
//  MapView
//
//  Created by Jon on 10/19/14.
//  Copyright (c) 2014 Jon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Parser.h"
#import "Bar.h"

@interface ViewController : UIViewController<CLLocationManagerDelegate, MKMapViewDelegate> {
MKMapView *mapView;
}
@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *location;
@property Bar* selectedBar;

- (IBAction)setMap:(id)sender;
- (void) doParse:(NSData *)data;
-(double) getMetersFromMiles:(double) miles;
@end

