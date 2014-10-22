//
//  MapPin.m
//  MapView
//
//  Created by Jon on 10/19/14.
//  Copyright (c) 2014 Jon. All rights reserved.
//

#import "MapPin.h"

@implementation MapPin
@synthesize coordinate, title, subtitle;

/*- (MKAnnotationView *)mapView:(MKMapView *)mapView
            viewForAnnotation:(id<MKAnnotation>)annotation {
    MKAnnotationView* aView = [[MKAnnotationView alloc] initWithAnnotation:annotation
                               
                                                           reuseIdentifier:@"MyCustomAnnotation"];
    
    aView.image = [UIImage imageNamed:@"beer_48.png"];
    
    //aView.centerOffset = CGPointMake(10, -20);
    return aView;
}
*/

- (MKAnnotationView *)mapView:(MKMapView *)mapView

            viewForAnnotation:(id <MKAnnotation>)annotation

{
    
    // If the annotation is the user location, just return nil.
    
    if ([annotation isKindOfClass:[MKUserLocation class]])
        
        return nil;
    
    
    
    // Handle any custom annotations.
    
    if ([annotation isKindOfClass:[MapPin class]])
        
    {
        
        // Try to dequeue an existing pin view first.
        
        MKPinAnnotationView*    pinView = (MKPinAnnotationView*)[mapView
                                                                 
                                                                 dequeueReusableAnnotationViewWithIdentifier:@"CustomPinAnnotationView"];
        
        
        
        if (!pinView)
            
        {
            
            // If an existing pin view was not available, create one.
            
            pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation
                       
                                                      reuseIdentifier:@"CustomPinAnnotationView"];
            
            pinView.pinColor = MKPinAnnotationColorGreen;
            
            pinView.animatesDrop = YES;
            
            pinView.canShowCallout = YES;
            
            
            
            // If appropriate, customize the callout by adding accessory views (code not shown).
            
        }
        
        else
            
            pinView.annotation = annotation;
        
        
        
        return pinView;
        
    }
    
    
    
    return nil;
    
}



@end
