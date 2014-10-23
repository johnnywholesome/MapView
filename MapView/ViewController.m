//
//  ViewController.m
//  MapView
//
//  Created by Jon on 10/19/14.
//  Copyright (c) 2014 Jon. All rights reserved.
//

#import "ViewController.h"
#import "PEConstants.h"
#import "BarDetailViewController.h"

@interface ViewController () {
    Bar *selectedBar;
}

@end

@implementation ViewController
@synthesize mapView;
@synthesize locationManager;
@synthesize location;
@synthesize selectedBar;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // get current location
    [self getCurrentLocation];
    
    // set MKMapViewDelegate to self
    self.mapView.delegate =self;
    
    // create pointer to bar data xml file
    NSData *data = [self setData];
    
    // parse xml file and add annotations to map
    [self doParse:data];
    
    [self zoomIn];
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

// Gets the user's current location
-(void) getCurrentLocation {
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    // Check for iOS 8. Without this guard the code will crash with "unknown selector" on iOS 7.
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager startUpdatingLocation];
    //[self.locationManager stopUpdatingLocation];
    
    self.location = [locationManager location];
    float longitude=self.location.coordinate.longitude;
    float latitude=self.location.coordinate.latitude;
    NSLog(@"Latitude: %f -- Longitude %f", latitude, longitude);
}

// Sets the data file to pass to NSXMLParser
- (NSData *) setData {
    NSString *urlString = [NSString stringWithFormat:@"http://www.alcohost.com/global_bars_xml_edit.php?today=%@",[self today]];
    NSURL *url = [[NSURL alloc]initWithString:urlString];
    NSData *data = [[NSData alloc] initWithContentsOfURL:url];
    return data;
}

// Method to parse XML file
- (void) doParse:(NSData *)data {
    // create and init NSXMLParser object
    NSXMLParser *nsXmlParser = [[NSXMLParser alloc] initWithData:data];
    // create and init the delegate
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
    pin.phone = bar.phone;
    pin.special = bar.special;
    
    MKCoordinateRegion pinRegion;
    pinRegion.center.latitude = bar.lat;
    pinRegion.center.longitude = bar.lng;
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

// Location Manager Delegate Methods
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"%@", [locations lastObject]);
}

// MapView Delegate methods
- (void) mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views {
    //[self zoomIn];
}

// annotation view assignment
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    NSString *reuseIdentifier = @"Bar";
    Bar *customAnnotationView = (Bar *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:reuseIdentifier];
   
    if (!customAnnotationView) {
        customAnnotationView = [[Bar alloc]initWithAnnotationWithImage:annotation reuseIdentifier:reuseIdentifier annotationViewImage:[UIImage imageNamed:@"beer_48.png"]];
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
    
    // set bar detail properties
    [detailView setBarName:self.selectedBar.name];
    [detailView setBarAddress:[NSString stringWithFormat:@"%@\n%@, %@, %@",self.selectedBar.street, self.selectedBar.city, self.selectedBar.state, self.selectedBar.zip]];
    [detailView setBarSpecial:self.selectedBar.special];
    [detailView setBar:selectedBar];
}

@end
