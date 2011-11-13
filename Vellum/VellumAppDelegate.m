//
//  VellumAppDelegate.m
//  Vellum
//
//  Created by Nat Budin on 6/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "VellumAppDelegate.h"
#import "Project.h"
#import "SugarPondLoginViewController.h"
#import <RestKit/RestKit.h>
#import <RestKit/ObjectMapping/RKRailsRouter.h>
#import <RestKit/CoreData/CoreData.h>
#import "Attr.h"

@implementation VellumAppDelegate


@synthesize window=_window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    // Add the navigation controller's view to the window and display.
//    self.window.rootViewController = self.splitViewController;
    [self.window makeKeyAndVisible];
    
    RKRailsRouter *router = [[RKRailsRouter alloc] init];
    [router setModelName:@"project" forClass:[Project class]];
    [router routeClass:[Project class] toResourcePath:@"/projects.json" forMethod:RKRequestMethodGET];
    [router routeClass:[Project class] toResourcePath:@"/projects/(identifier).json"];
    [router routeClass:[Project class] toResourcePath:@"/projects.json" forMethod:RKRequestMethodPOST];
    
    [router setModelName:@"doc" forClass:[Doc class]];
    [router routeClass:[Doc class] toResourcePath:@"/projects/(project.identifier)/docs/(identifier).json"];
    [router routeClass:[Doc class] toResourcePath:@"/projects/(project.identifier)/docs.json" forMethod:RKRequestMethodPOST];

    RKObjectManager* manager = [RKObjectManager objectManagerWithBaseURL:@"http://vellum.aegames.org"];
    manager.router = router;
    manager.objectStore = [RKManagedObjectStore objectStoreWithStoreFilename:@"Vellum.db"];
    [manager.mapper registerClass:[Attr class] forElementNamed:@"attrs"];
    [RKObjectManager setSharedManager:manager];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}


@end
