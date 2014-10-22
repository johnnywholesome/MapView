//
//  ViewController.m
//  MapView
//
//  Created by Jon on 10/19/14.
//  Copyright (c) 2014 Jon. All rights reserved.
//

#import "ViewController.h"
#import "MapPin.h"
#import "PEConstants.h"

@interface ViewController () 

@end

@implementation ViewController
@synthesize mapView;
@synthesize locationManager;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // ** Don't forget to add NSLocationWhenInUseUsageDescription in MyApp-Info.plist and give it a string
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    // Check for iOS 8. Without this guard the code will crash with "unknown selector" on iOS 7.
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager startUpdatingLocation];
    //[self.locationManager stopUpdatingLocation];
    CLLocation *location = [locationManager location];
    float longitude=location.coordinate.longitude;
    float latitude=location.coordinate.latitude;
    NSLog(@"Latitude: %f -- Longitude %f", latitude, longitude);
    
    MKCoordinateRegion region = { {0.0, 0.0}, {0.0, 0.0} };
    region.center.latitude = latitude;
    region.center.longitude = longitude;
    region.span.longitudeDelta = 0.01f;
    region.span.latitudeDelta = 0.01f;
    [mapView setRegion:region animated:YES];
    
    /*
     MapPin *pin = [[MapPin alloc] init];
    pin.title = @"Golden Gate Bridge";
    pin.subtitle = @"This is the coolest bridge in San Francisco.";
    MKCoordinateRegion pinRegion;
    pinRegion.center.latitude = 37.8197222;
    pinRegion.center.longitude = -122.4788889;
    pin.coordinate = pinRegion.center;
    [mapView addAnnotation:pin];
    */
    NSString *urlString = [NSString stringWithFormat:@"http://www.alcohost.com/global_bars_xml_edit.php?today=%@",[self today]];
    NSURL *url = [[NSURL alloc]initWithString:urlString];
    NSData *data = [[NSData alloc] initWithContentsOfURL:url];
    [self doParse:data];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)setMap:(id)sender {
    switch (((UISegmentedControl *) sender).selectedSegmentIndex) {
        case 0:
            mapView.mapType = MKMapTypeStandard;
            break;
        case 1:
            mapView.mapType = MKMapTypeSatellite;
            break;
        case 2:
            mapView.mapType = MKMapTypeHybrid;
            break;
            
        default:
            break;
    }
}

// Location Manager Delegate Methods
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"%@", [locations lastObject]);
}

- (IBAction)getLocation:(id)sender {
    mapView.showsUserLocation = YES;
}

- (IBAction)direction:(id)sender {
    NSString *urlString = @"http://maps.apple.com/maps?daddr=37.8197222,-122.4788889";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}

// Method to parse XML file
- (void) doParse:(NSData *)data {
    
    // create and init NSXMLParser object
    NSXMLParser *nsXmlParser = [[NSXMLParser alloc] initWithData:data];
    
    // create and init our delegate
    Parser *parser = [[Parser alloc] initXMLParser];
    
    // set delegate
    [nsXmlParser setDelegate:parser];
    
    // parsing...
    BOOL success = [nsXmlParser parse];
    
    // test the result
    if (success) {
        NSLog(@"Success!");
        // get array of users here
        //  NSMutableArray *users = [parser users];
        
        for (Bar *bar in parser.bars) {
            if (bar)
            [self createMarkerForBar:bar];
        }
    } else {
        NSLog(@"Error parsing document!");
    }
}

-(void) createMarkerForBar:(Bar *)bar {
 
     MapPin *pin = [[MapPin alloc] init];
     pin.title = bar.name;
     pin.subtitle = bar.mon;
     MKCoordinateRegion pinRegion;
     pinRegion.center.latitude = bar.lat;
     pinRegion.center.longitude = bar.lng;
     pin.coordinate = pinRegion.center;
     [mapView addAnnotation:pin];
}

-(NSString *) today {
    NSDate *today = [NSDate date];
    NSDateFormatter *myFormatter = [[NSDateFormatter alloc] init];
    [myFormatter setDateFormat:@"EEEE"]; // day, like "Saturday"
    [myFormatter setDateFormat:@"c"]; // day number, like 7 for saturday
    return[myFormatter stringFromDate:today];
}

@end
