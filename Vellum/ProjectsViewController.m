//
//  ProjectsViewController.m
//  Vellum
//
//  Created by Nat Budin on 6/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ProjectsViewController.h"
#import "DocsListViewController.h"
#import "SugarPondLoginViewController.h"
#import "ProjectCell.h"

@implementation ProjectsViewController

+(Class)objectClass {
    return [Project class];
}

-(NSString *)resourcePath {
    return @"/projects.json";
}


 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (objects == nil) {
        [self reloadObjects];
        return 0;
    } else {
        NSLog(@"Returning %d\n", [objects count]);
        return [objects count];
    }
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Project *project = [objects objectAtIndex:[indexPath indexAtPosition:1]];   
    ProjectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProjectCell"];
    cell.project = project;

    // Configure the cell.
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"projectSelected"]) {
        ProjectCell *cell = (ProjectCell *)sender;
        DocsListViewController *dest = (DocsListViewController *)segue.destinationViewController;
        dest.project = cell.project;
    }
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];

    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


@end
