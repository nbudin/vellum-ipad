//
//  VellumManagedObjectCache.m
//  Vellum for iPad
//
//  Created by Nathaniel Budin on 6/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "VellumManagedObjectCache.h"
#import "Project.h"

@implementation VellumManagedObjectCache

-(NSArray *)fetchRequestsForResourcePath:(NSString *)resourcePath {
    if ([resourcePath isEqualToString:@"/projects.json"]) {
        NSFetchRequest* request = [Project fetchRequest];
		//NSSortDescriptor* sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"createdAt" ascending:YES];
		//[request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
		return [NSArray arrayWithObject:request];
    }
    
    return nil;
}

@end
