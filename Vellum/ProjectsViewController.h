//
//  ProjectsViewController.h
//  Vellum
//
//  Created by Nat Budin on 6/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>
#import "Project.h"
#import "SugarPondLoginDelegate.h"

@interface ProjectsViewController : UITableViewController<RKObjectLoaderDelegate, SugarPondLoginDelegate> {
    NSArray *projects;
}

-(void)reloadProjects;

@end
