//
//  Project.m
//  Vellum for iPad
//
//  Created by Nat Budin on 6/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Project.h"
#import "DocTemplate.h"

@implementation Project

@dynamic name, identifier, docs, docTemplates;

+(NSDictionary *)elementToPropertyMappings {
    return [NSDictionary dictionaryWithKeysAndObjects:
            @"name", @"name",
            @"id", @"identifier",
            nil];
}

-(NSString *)description {
    return [NSString stringWithFormat:@"<Project:%@>", self.name];
}

+(NSString *)primaryKeyProperty {
    return @"identifier";
}

-(NSArray *)docTemplatesOrderedByName {
    NSFetchRequest *fetchRequest = [DocTemplate fetchRequest];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"projectId = %@", self.identifier]];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]]];
    
    return [DocTemplate objectsWithFetchRequest:fetchRequest];
}

@end
