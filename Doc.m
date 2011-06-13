//
//  Doc.m
//  Vellum for iPad
//
//  Created by Nathaniel Budin on 6/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Doc.h"

@implementation Doc
@dynamic identifier, position, version, docTemplate, docTemplateId, project, projectId, name, content, blurb, attrs;

+(NSDictionary *)elementToPropertyMappings {
    return [NSDictionary dictionaryWithKeysAndObjects:
            @"id", @"identifier", 
            @"position", @"position",
            @"version", @"version",
            @"doc_template_id", @"docTemplateId",
            @"project_id", @"projectId",
            @"name", @"name",
            @"content", @"content",
            @"blurb", @"blurb",
            nil];
}

+(NSDictionary *)elementToRelationshipMappings {
    return [NSDictionary dictionaryWithKeysAndObjects:
            @"attrs", @"attrs", 
            nil];
}

+(NSDictionary *)relationshipToPrimaryKeyPropertyMappings {
    return [NSDictionary dictionaryWithKeysAndObjects:
            @"project", @"projectId",
            @"docTemplate", @"docTemplateId", 
            nil];
}

-(NSString *)description {
    return [NSString stringWithFormat:@"<Doc: %@>",
            self.name];
}

+(NSString *)primaryKeyProperty {
    return @"identifier";
}

@end
