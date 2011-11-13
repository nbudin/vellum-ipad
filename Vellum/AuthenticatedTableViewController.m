//
//  AuthenticatedTableViewController.m
//  
//
//  Created by Nathaniel Budin on 6/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AuthenticatedTableViewController.h"
#import "SugarPondLoginViewController.h"

@implementation AuthenticatedTableViewController
@synthesize objects;

static AuthenticatedTableViewController *presentingLoginView = nil;

- (void)reloadObjects {
    if (![SugarPondLoginViewController loggedIn]) {
        if (presentingLoginView == nil) {
            presentingLoginView = self;
            
            [self presentModalViewController:[SugarPondLoginViewController sharedInstance] animated:YES];

            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginCompleted) name:SugarPondLoginCompleted object:nil];
        }
    } else {
        [[RKObjectManager sharedManager] loadObjectsAtResourcePath:[self resourcePath]
                                                       objectClass:[[self class] objectClass] 
                                                          delegate:self];
    }
}

- (void)loadObjectsFromDatastore {
    
    NSFetchRequest *request = [[[self class] objectClass] fetchRequest];
    NSSortDescriptor *descriptor = [self sortDescriptor];
    if (descriptor != nil) {
        [request setSortDescriptors:[NSArray arrayWithObject:descriptor]];
    }
    objects = [[[self class] objectClass] objectsWithFetchRequest:request];
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error { 
    NSLog(@"Error loading objects: %@\n", error);
    
    NSLog(@"RKClient network available: %@, reachabilty observer: %@", [[RKClient sharedClient] isNetworkAvailable], [[RKClient sharedClient] baseURLReachabilityObserver]);
    
    NSLog(@"Method: %@", [objectLoader method]);
    NSLog(@"Resource path: %@", [objectLoader resourcePath]);
    NSLog(@"Response: %@", [objectLoader response]);
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)loadedObjects {
    NSLog(@"Loaded objects: %@\n", loadedObjects);
    [self loadObjectsFromDatastore];
    [self.tableView reloadData];
}

- (void)objectLoaderDidLoadUnexpectedResponse:(RKObjectLoader *)objectLoader {
    NSLog(@"Got unexpected response: %@\n", [objectLoader response]);
}

- (void)loginCompleted {
    [self dismissModalViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SugarPondLoginCompleted object:nil];
    presentingLoginView = nil;
    [self reloadObjects];
}

- (NSSortDescriptor *)sortDescriptor {
    return [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES selector:@selector(caseInsensitiveCompare:)];
}

- (NSString *)resourcePath {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)] userInfo:nil];
}

+ (Class)objectClass {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)] userInfo:nil];
}
@end
