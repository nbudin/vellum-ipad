//
//  Project.h
//  Vellum for iPad
//
//  Created by Nat Budin on 6/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>
#import <RestKit/CoreData/CoreData.h>

@interface Project : RKManagedObject 

@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSNumber* identifier;
@property (nonatomic, retain) NSSet* docTemplates;
@property (nonatomic, retain) NSSet* docs;

-(NSArray *)docTemplatesOrderedByName;

@end
