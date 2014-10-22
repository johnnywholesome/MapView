//
//  Bar.h
//  XMLParser
//
//  Created by Jon on 10/20/14.
//  Copyright (c) 2014 Jon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface Bar : MKAnnotationView <MKAnnotation> {
    CLLocationCoordinate2D coordinate;
    NSString *title;
    NSString *subtitle;
}
// Bar properties
@property (nonatomic) NSInteger barId;
@property (strong, nonatomic) NSString *name, *street, *city, *state, *zip, *phone, *neighborhood, *hours, *url, *special;
@property (nonatomic) double lat, lng;
@property (strong, nonatomic) NSMutableDictionary *barDetails;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation;


// constructor
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
             special:(NSString *)special;

-(id) initWithAnnotationWithImage:(id<MKAnnotation>)annotation
                  reuseIdentifier:(NSString *)reuseIdentifier
              annotationViewImage:(UIImage*)anonViewImage;


@end
