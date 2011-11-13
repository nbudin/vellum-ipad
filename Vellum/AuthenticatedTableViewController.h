//
//  AuthenticatedTableViewController.h
//  
//
//  Created by Nathaniel Budin on 6/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <RestKit/RestKit.h>
#import <RestKit/CoreData/CoreData.h>

@interface AuthenticatedTableViewController : UITableViewController<RKObjectLoaderDelegate> {
    NSArray *objects;
}

@property (readonly) NSArray *objects;

-(void)reloadObjects;
-(void)loadObjectsFromDatastore;
-(void)loginCompleted;

-(NSString *)resourcePath;
-(NSSortDescriptor *)sortDescriptor;
+(Class)objectClass;

@end
