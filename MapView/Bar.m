//
//  Bar.m
//  XMLParser
//
//  Created by Jon on 10/20/14.
//  Copyright (c) 2014 Jon. All rights reserved.
//

#import "Bar.h"

@implementation Bar

@synthesize barId, name=_name, street=_street, city=_city, state=_state, zip=_zip, lat=_lat, lng=_lng, phone=_phone, neighborhood=_neighborhood, hours=_hours, url=_url, mon=_mon, tue=_tue, wed=_wed, thu=_thu, fri=_fri, sat=_sat, sun=_sun, barDetails=_barDetails;

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
             mon:(NSString *)mon
             tue:(NSString *)tue
             wed:(NSString *)wed
             thu:(NSString *)thu
             fri:(NSString *)fri
             sat:(NSString *)sat
             sun:(NSString *)sun {
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
                           @"mon", mon,
                           @"tue", tue,
                           @"wed", wed,
                           @"thu", thu,
                           @"fri", fri,
                           @"sat", sat,
                           @"sun", sun,
                           nil];
    }
    return self;
}
@end