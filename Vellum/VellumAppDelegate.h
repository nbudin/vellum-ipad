//
//  VellumAppDelegate.h
//  Vellum
//
//  Created by Nat Budin on 6/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>
#import <RestKit/ObjectMapping/RKRailsRouter.h>
#import "LoginViewController.h"
#import "ProjectsViewController.h"
#import "DetailViewController.h"

@interface VellumAppDelegate : NSObject <UIApplicationDelegate, UISplitViewControllerDelegate, SugarPondLoginDelegate> {

    LoginViewController *_loginViewController;
    UISplitViewController *_splitViewController;
    ProjectsViewController *_projectsViewController;
    DetailViewController *_detailViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) IBOutlet LoginViewController *loginViewController;
@property (nonatomic, retain) IBOutlet UISplitViewController *splitViewController;
@property (nonatomic, retain) IBOutlet ProjectsViewController *projectsViewController;
@property (nonatomic, retain) IBOutlet DetailViewController *detailViewController;

@property (nonatomic, retain) RKRailsRouter *router;

@end
