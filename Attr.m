//
//  Attr.m
//  Vellum for iPad
//
//  Created by Nathaniel Budin on 6/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Attr.h"

@implementation Attr

@synthesize name=_name, value=_value;

+(NSDictionary *)elementToPropertyMappings {
    return [NSDictionary dictionaryWithKeysAndObjects:
            @"name", @"name",
            @"value", @"value",
            nil];
}

-(NSString *)description {
    return [NSString stringWithFormat:@"<Attr: %@ -> %@>",
            self.name, self.value];
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeObject:_value forKey:@"value"];
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    self.name = [aDecoder decodeObjectForKey:@"name"];
    self.value = [aDecoder decodeObjectForKey:@"value"];
    return self;
}

@end
