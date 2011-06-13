//
//  Doc.h
//  Vellum for iPad
//
//  Created by Nathaniel Budin on 6/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>
#import <RestKit/CoreData/CoreData.h>

#import "Project.h"
#import "DocTemplate.h"

@interface Doc : RKManagedObject

@property (nonatomic, retain) NSNumber *identifier;
@property (nonatomic, retain) NSNumber *position;
@property (nonatomic, retain) NSNumber *version;

@property (nonatomic, retain) NSNumber *docTemplateId;
@property (nonatomic, retain) DocTemplate *docTemplate;
@property (nonatomic, retain) NSNumber *projectId;
@property (nonatomic, retain) Project *project;

@property (nonatomic, retain) NSString *content;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *blurb;

@property (nonatomic, retain) NSArray *attrs;


@end