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
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

@interface ViewController : UIViewController<CLLocationManagerDelegate, MKMapViewDelegate> {

}
@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property CLLocationDegrees currentLatitude;
@property CLLocationDegrees currentLongitude;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (readwrite, nonatomic) CLLocation *location;
@property (strong, nonatomic) NSData *data;
@property Bar* selectedBar;
@property(nonatomic)NSTimer *timer;
@property (nonatomic) BOOL found;

-(void) getCurrentLocation;
- (IBAction)setMap:(id)sender;
- (void) parseXmlData:(NSData *)data;
-(double) getMetersFromMiles:(double) miles;
@end

