//
//  Parser.m
//  XMLParser
//
//  Created by Jon on 10/20/14.
//  Copyright (c) 2014 Jon. All rights reserved.
//

#import "Parser.h"

@implementation Parser
@synthesize theBar=_theBar, bars=_bars, currentElementValue=_currentElementValue;


- (Parser *) initXMLParser {
    if (self = [super init]) {
        // init array of user objects
        _bars = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    if ([elementName isEqualToString:@"bar"]) {
        theBar = [[Bar alloc]init];
        //Extract any attributes in the bar elements here
        theBar.barId = (NSInteger) [attributeDict valueForKey:@"id"];
    }
}


-(void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if (!currentElementValue) {
        // init the ad hoc string with the value
        currentElementValue = [[NSMutableString alloc] initWithString:string];
    } else {
        // append value to the ad hoc string
        [currentElementValue appendString:string];
    }
    //NSLog(@"Processing value for : %@", string);

}

-(void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if ([elementName isEqualToString:@"bars"]) {
        // We reached the end of the XML document
        //[self printBarArray];
        return;
    }
    
    if ([elementName isEqualToString:@"bar"]) {
        // We are done with bar entry – add the parsed bar
        // object to our bar array
        [_bars addObject:theBar];
        theBar = nil;
    } else {
        // The parser hit one of the element values.
        // This syntax is possible because bar object
        // property names match the XML user element names
        
        if ([elementName isEqualToString:@"name"]) {
            [theBar.barDetails setObject:currentElementValue forKey:elementName];
        }
        
        [theBar setValue:currentElementValue forKey:elementName];
    }
    
    currentElementValue = nil;
}

-(void) printBarArray {
    for (Bar *bar in _bars) {
        NSLog(@"Title:  %@", bar.name);
    }
}

@end
