//
//  ViewController.m
//  MapView
//
//  Created by Jon on 10/19/14.
//  Copyright (c) 2014 Jon. All rights reserved.
//

#import "ViewController.h"
#import "BarDetailViewController.h"

@interface ViewController () {
    Bar *selectedBar;
}

@end

@implementation ViewController
@synthesize mapView, locationManager, location, selectedBar, currentLatitude, currentLongitude, found;

- (void)viewDidLoad {
    [super viewDidLoad];
    // set MKMapViewDelegate to self
    self.mapView.delegate =self;
    
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];
    
    // Check for iOS 8. Without this guard the code will crash with "unknown selector" on iOS 7.
    if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [locationManager requestWhenInUseAuthorization];
    }
    //[locationManager startUpdatingLocation];
    //[self getCurrentLocation];
    
    // create pointer to bar data xml file
    self.data = [self setData];
    
    // parse xml file and add annotations to map
    [self parseXmlData:self.data];
    
    // Determine if the user authorized location services
    [self checkStatus];

}


// Check authorization status
-(void)checkStatus{
    
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    
    if (status==kCLAuthorizationStatusNotDetermined) {
        [self getCurrentLocation];
        NSLog(@"Permission Undetermined.");
        if (self.isFound) {
            [self zoomIn];
        }
        else {
            [self zoomInOnCityNamed:@"Chicago"];
        }
        
    }
    
    if (status==kCLAuthorizationStatusDenied) {
        NSLog(@"Permission Denied");
        [self zoomInOnCityNamed:@"Chicago"];
    }
    
    if (status==kCLAuthorizationStatusRestricted) {
        NSLog(@"Permission Authorization Status Restricted");
        [self zoomInOnCityNamed:@"Chicago"];
        
    }
    
    if (status==kCLAuthorizationStatusAuthorizedAlways) {
        NSLog(@"Permission Authorized Always On");
        //[self getCurrentLocation];
    }
    
    if (status==kCLAuthorizationStatusAuthorizedWhenInUse) {
        NSLog(@"Permission Authorized When In Use");
        [self getCurrentLocation];
        if (self.isFound) {
            [self zoomIn];
        }
        else {
            [self zoomInOnCityNamed:@"Chicago"];
        }
       
        //[self zoomIn];
    }
    
}

// Gets the user's current location
-(void) getCurrentLocation {
    
        location = [[CLLocation alloc]init];
        location = [locationManager location];
        [self setCurrentLongitude:location.coordinate.longitude];
        [self setCurrentLatitude:location.coordinate.latitude];
    
    NSLog(@"Latitude: %f -- Longitude %f", currentLatitude, currentLongitude);
}

-(BOOL)isFound {
    return (currentLongitude != 0.000000 && currentLatitude != 0.000000);
}

// Converts miles to meters
-(double) getMetersFromMiles:(double) miles {
    return miles * 1609.344;
}

// zoom in to current location
- (void) zoomIn {
    
    MKCoordinateRegion region =
    MKCoordinateRegionMakeWithDistance (
                                        self.location.coordinate, [self getMetersFromMiles:5], [self getMetersFromMiles:5]);
    [self.mapView setRegion:region animated:YES];
}

- (void) zoomInOnCityNamed:(NSString*)city {
    if ([city  isEqual: @"Chicago"]) {
        location = [[CLLocation alloc]initWithLatitude:41.917488 longitude:-87.658318];
    }
    MKCoordinateRegion region =
    MKCoordinateRegionMakeWithDistance (
                                        self.location.coordinate, [self getMetersFromMiles:10], [self getMetersFromMiles:10]);
    [self.mapView setRegion:region animated:YES];
}

// Delegate method from the CLLocationManagerDelegate protocol.

- (void)locationManager:(CLLocationManager *)manager

     didUpdateLocations:(NSArray *)locations {
    location = [[CLLocation alloc]init];
    location = [locations lastObject];
    [self setCurrentLongitude:location.coordinate.latitude];
    [self setCurrentLongitude:location.coordinate.longitude];
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    location = [[CLLocation alloc]initWithLatitude:newLocation.coordinate.latitude longitude:newLocation.coordinate.longitude];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    [locationManager stopUpdatingLocation];
    location = [[CLLocation alloc]initWithLatitude:41.980212 longitude:-87.718797];
    [self setCurrentLatitude:location.coordinate.latitude];
    [self setCurrentLongitude:location.coordinate.longitude];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Button Control for Standard, Satellite, and Hybrid Map Views
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

// Sets the data file to pass to NSXMLParser
- (NSData *) setData {
    NSString *urlString = [NSString stringWithFormat:@"http://www.alcohost.com/global_bars_xml_edit.php?today=%@",[self today]];
    NSURL *url = [[NSURL alloc]initWithString:urlString];
    NSData *data = [[NSData alloc] initWithContentsOfURL:url];
    return data;
}


// Method to parse XML file
- (void) parseXmlData:(NSData *)data {
    // create and init NSXMLParser object
    NSXMLParser *nsXmlParser = [[NSXMLParser alloc] initWithData:data];
    // create and init the delegate
    Parser *parser = [[Parser alloc] initXMLParser];
    // set delegate
    [nsXmlParser setDelegate:parser];
    // parsing...
    //BOOL success = [nsXmlParser parse];
    // test the result
    if ([nsXmlParser parse]) {
        NSLog(@"Success!");
        // get array of bars here
        // Add Annotations to the MapView
        for (Bar *bar in parser.bars) {
            if (bar)
            [self createMarkerForBar:bar];
        }
    } else {
        NSLog(@"Error parsing document!");
    }
}

// Places an annotation on the MapView
-(void) createMarkerForBar:(Bar *)bar {
 
    Bar *pin = [[Bar alloc] init];
    pin.title = bar.name;
    pin.subtitle = bar.special;
    pin.name = bar.name;
    pin.street = bar.street;
    pin.city = bar.city;
    pin.state = bar.state;
    pin.zip = bar.zip;
    pin.lat = bar.lat;
    pin.lng = bar.lng;
    pin.phone = bar.phone;
    pin.neighborhood = bar.neighborhood;
    pin.hours = bar.hours;
    pin.special = bar.special;

    MKCoordinateRegion pinRegion;
    pinRegion.center.latitude = pin.lat;
    pinRegion.center.longitude = pin.lng;
    pin.coordinate = pinRegion.center;
    [mapView addAnnotation:pin];
}

// Get's the day of the week
-(NSString *) today {
    NSDate *today = [NSDate date];
    NSDateFormatter *myFormatter = [[NSDateFormatter alloc] init];
    [myFormatter setDateFormat:@"EEEE"]; // day, like "Saturday"
    [myFormatter setDateFormat:@"c"]; // day number, like 7 for saturday
    return[myFormatter stringFromDate:today];
}


// MapView Delegate methods
- (void) mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views {
    //[self zoomIn];
}

// annotation view assignment
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if([annotation isKindOfClass:[MKUserLocation class]]) {
        [self zoomIn];
        return nil;
    }
    
    NSString *reuseIdentifier = @"Bar";
    Bar *customAnnotationView = (Bar *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:reuseIdentifier];
   
    if (!customAnnotationView) {
        customAnnotationView = [[Bar alloc]initWithAnnotationWithImage:annotation reuseIdentifier:reuseIdentifier annotationViewImage:[UIImage imageNamed:@"beer_24.png"]];
        customAnnotationView.annotation = annotation;
        customAnnotationView.canShowCallout=YES;
        
        // Setup side views here
        // Left one
        //UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 46, 46)];
        //customAnnotationView.leftCalloutAccessoryView = imageView;
        
        //Right One
        UIButton *disclosureButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        
        //[disclosureButton sizeToFit];
        customAnnotationView.rightCalloutAccessoryView = disclosureButton;
    }
    return customAnnotationView;
}

-(void) mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    if (control == view.rightCalloutAccessoryView) {
        
        selectedBar = [[Bar alloc]init];
        selectedBar = (Bar *)view.annotation;
        
        [self performSegueWithIdentifier:@"Show Bar Details" sender:selectedBar];
    }
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    BarDetailViewController *detailView = [segue destinationViewController];
    
    // passing along needed data
    [detailView setCurrentLatitude:self.currentLatitude];
    [detailView setCurrentLongitude:self.currentLongitude];
    //NSLog(NSString stringWithFormat:@"%ld, %ld", self.currentLatitude, self.currentLongitude);
    [detailView setBar:selectedBar];
}

@end
