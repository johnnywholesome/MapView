//
//  Parser.h
//  XMLParser
//
//  Created by Jon on 10/20/14.
//  Copyright (c) 2014 Jon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Bar.h"

@interface Parser : NSObject <NSXMLParserDelegate> {
    Bar *theBar;
    
    NSMutableString *currentElementValue;
}
@property (strong, nonatomic) NSMutableString *currentElementValue;
@property (strong, nonatomic) NSMutableArray *bars;
@property (nonatomic, retain) Bar *theBar;

-(Parser *) initXMLParser;

@end
