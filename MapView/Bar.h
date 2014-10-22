//
//  Bar.h
//  XMLParser
//
//  Created by Jon on 10/20/14.
//  Copyright (c) 2014 Jon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Bar : NSObject
// Bar properties
@property (nonatomic) NSInteger barId;
@property (strong, nonatomic) NSString *name, *street, *city, *state, *zip, *phone, *neighborhood, *hours, *url, *mon, *tue, *wed, *thu, *fri, *sat, *sun;
@property (nonatomic) double lat, lng;
@property (strong, nonatomic) NSMutableDictionary *barDetails;


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
             mon:(NSString *)mon
             tue:(NSString *)tue
             wed:(NSString *)wed
             thu:(NSString *)thu
             fri:(NSString *)fri
             sat:(NSString *)sat
             sun:(NSString *)sun;
@end
