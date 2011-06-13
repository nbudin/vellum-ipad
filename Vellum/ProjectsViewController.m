//
//  ProjectsViewController.m
//  Vellum
//
//  Created by Nat Budin on 6/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ProjectsViewController.h"
#import "DocsListViewController.h"

@implementation ProjectsViewController
@synthesize navigationController=_navigationController, detailViewController=_detailViewController;

- (void)reloadProjects {
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:@"/projects.json" 
                                                   objectClass:[Project class] 
                                                      delegate:self];
}

- (void)loadProjectsFromDatastore {
    [projects release];
    
    NSFetchRequest *request = [Project fetchRequest];
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES selector:@selector(caseInsensitiveCompare:)];
    [request setSortDescriptors:[NSArray arrayWithObject:descriptor]];
    projects = [[Project objectsWithFetchRequest:request] retain];
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error { 
    NSLog(@"Error loading projects: %@\n", error);
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects {
    NSLog(@"Loaded projects: %@\n", objects);
    [self loadProjectsFromDatastore];
    [self.tableView reloadData];
}

- (void)objectLoaderDidLoadUnexpectedResponse:(RKObjectLoader *)objectLoader {
    NSLog(@"Got unexpected response: %@\n", [objectLoader response]);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Projects";
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
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
    if (projects == nil) {
        [self reloadProjects];
        return 0;
    } else {
        NSLog(@"Returning %d\n", [projects count]);
        return [projects count];
    }
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Project *project = [projects objectAtIndex:[indexPath indexAtPosition:1]];
    NSString *CellIdentifier = [NSString stringWithFormat:@"%d", project.identifier];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    [[cell textLabel] setText:[project name]];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];

    // Configure the cell.
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Project *project = [projects objectAtIndex:[indexPath indexAtPosition:1]];
    DocsListViewController *docsList = [[DocsListViewController alloc] initWithNibName:@"DocsListViewController" bundle:nil];
    docsList.project = project;
    docsList.title = project.name;
    docsList.detailViewController = self.detailViewController;
    [docsList reloadDocs];
    
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:docsList animated:YES];
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

- (void)dealloc
{
    [super dealloc];
    [projects release];
}

@end
