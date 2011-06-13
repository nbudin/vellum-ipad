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
#import "DetailViewController.h"

@interface ProjectsViewController : UITableViewController<RKObjectLoaderDelegate> {
    NSArray *projects;
}

@property (nonatomic, assign) IBOutlet UINavigationController *navigationController;
@property (nonatomic, assign) IBOutlet DetailViewController *detailViewController;

-(void)reloadProjects;
-(void)loadProjectsFromDatastore;

@end
