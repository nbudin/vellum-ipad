//
//  DocTemplate.h
//  Vellum for iPad
//
//  Created by Nathaniel Budin on 6/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>
#import <RestKit/CoreData/CoreData.h>
#import "Project.h"

@interface DocTemplate : RKManagedObject

@property (nonatomic, retain) NSNumber *identifier;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSNumber *projectId;
@property (nonatomic, retain) Project *project;
@property (nonatomic, retain) NSSet *docs;

-(NSArray *)docsOrderedByPosition;

@end
