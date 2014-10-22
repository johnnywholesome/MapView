//
//  Bar.m
//  XMLParser
//
//  Created by Jon on 10/20/14.
//  Copyright (c) 2014 Jon. All rights reserved.
//

#import "Bar.h"

@implementation Bar

@synthesize barId, name=_name, street=_street, city=_city, state=_state, zip=_zip, lat=_lat, lng=_lng, phone=_phone, neighborhood=_neighborhood, hours=_hours, url=_url, special=_special, barDetails=_barDetails;

@synthesize coordinate, title, subtitle;


-(id) initWithId:(NSInteger)barId
            name:(NSString *)name
          street:(NSString *)street
            city:(NSString *)city
           state:(NSString *)state
             zip:(NSString *)zip
             lat:(double)lat
             lng:(double)lng
           phone:(NSString *)phone
    neighborhood:(NSString *)neighborhood
           hours:(NSString *)hours
             url:(NSString *)url
             special:(NSString *)special {
    if (self = [super init]) {
        // initialize barDetails dictionary
        self.barDetails = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                           @"name", name,
                           @"street", street,
                           @"city", city,
                           @"state", state,
                           @"zip", zip,
                           @"lat", lat,
                           @"lng", lng,
                           @"phone", phone,
                           @"neighborhood", neighborhood,
                           @"hours", hours,
                           @"url", url,
                           @"special", special,
                           nil];
    }
    return self;
}

-(id) initWithAnnotationWithImage:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier annotationViewImage:(UIImage *)anonViewImage {
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    self.image = anonViewImage;
    return self;
}


- (MKAnnotationView *)mapView:(MKMapView *)mapView
            viewForAnnotation:(id<MKAnnotation>)annotation {
    MKAnnotationView* aView = [[MKAnnotationView alloc] initWithAnnotation:annotation
                               reuseIdentifier:@"Bar"];
    aView.image = [UIImage imageNamed:@"beer_48.png"];
    //aView.centerOffset = CGPointMake(10, -20);
    return aView;
}

@end