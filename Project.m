//
//  Project.m
//  Vellum for iPad
//
//  Created by Nat Budin on 6/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Project.h"


@implementation Project

@synthesize name=_name, identifier=_identifier;

+(NSDictionary *)elementToPropertyMappings {
    return [NSDictionary dictionaryWithKeysAndObjects:
            @"name", @"name",
            @"id", @"identifier",
            nil];
}

-(NSString *)description {
    return [NSString stringWithFormat:@"<Project:%@>", self.name];
}

@end
