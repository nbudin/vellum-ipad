//
//  VellumAppDelegate.m
//  Vellum
//
//  Created by Nat Budin on 6/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "VellumAppDelegate.h"
#import "Project.h"
#import "LoginViewController.h"

@implementation VellumAppDelegate


@synthesize window=_window;
@synthesize navigationController=_navigationController;
@synthesize loginViewController = _loginViewController;
@synthesize router=_router;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    // Add the navigation controller's view to the window and display.
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    
    self.router = [[RKRailsRouter alloc] init];
    [_router setModelName:@"project" forClass:[Project class]];
    [_router routeClass:[Project class] toResourcePath:@"/projects/(identifier).json"];
    [_router routeClass:[Project class] toResourcePath:@"/projects.json" forMethod:RKRequestMethodPOST];

    RKObjectManager* manager = [RKObjectManager objectManagerWithBaseURL:@"http://vellum.aegames.org"];
    manager.router = _router;
    [RKObjectManager setSharedManager:manager];
    
    self.loginViewController.loginDelegate = self.navigationController.topViewController;
    self.loginViewController.modalPresentationStyle = UIModalPresentationFormSheet;
    [self.navigationController presentModalViewController:self.loginViewController animated:YES];
    
//    RKObjectManager *manager = [RKObjectManager objectManagerWithBaseURL:@"http://vellum.aegames.org"];
//    [manager loadObjectsAtResourcePath:@"/projects.json" objectClass:[Project class] delegate:self];
//    [client get:@"/" delegate:self];
    
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

- (void)dealloc
{
    [_window release];
    [_navigationController release];
    [_loginViewController release];
    [super dealloc];
}

@end
