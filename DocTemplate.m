//
//  DocTemplate.m
//  Vellum for iPad
//
//  Created by Nathaniel Budin on 6/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DocTemplate.h"
#import "Doc.h"

@implementation DocTemplate

@dynamic identifier, name, project, projectId, docs;

+ (NSDictionary *)elementToPropertyMappings {
    return [NSDictionary dictionaryWithKeysAndObjects:
            @"id", @"identifier", 
            @"name", @"name",
            @"project_id", @"projectId",
            nil];
}

+(NSDictionary *)relationshipToPrimaryKeyPropertyMappings {
    return [NSDictionary dictionaryWithKeysAndObjects:
            @"project", @"projectId", 
            nil];
}

-(NSString *)description {
    return [NSString stringWithFormat:@"<DocTemplate: %@>",
            self.name];
}

+(NSString *)primaryKeyProperty {
    return @"identifier";
}

- (NSArray *)docsOrderedByPosition {
    NSFetchRequest *docFetchRequest = [Doc fetchRequest];
    [docFetchRequest setPredicate:[NSPredicate predicateWithFormat:@"projectId = %@ and docTemplateId = %@", self.projectId, self.identifier]];
    [docFetchRequest setSortDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"position" ascending:YES]]];
    
    return [Doc objectsWithFetchRequest:docFetchRequest];
}

@end
