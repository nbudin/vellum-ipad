//
//  DocsListViewController.m
//  Vellum for iPad
//
//  Created by Nathaniel Budin on 6/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DocsListViewController.h"

@implementation DocsListViewController

@synthesize project=_project, detailViewController=_detailViewController;

- (void)reloadDocs {
    NSString *resourcePath = [NSString stringWithFormat:@"/projects/%@/doc_templates.json",
                              self.project.identifier];
    
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:resourcePath
                                                   objectClass:[DocTemplate class] 
                                                      delegate:self];
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects {
    if ([objectLoader.resourcePath hasSuffix:@"/docs.json"]) {
        NSLog(@"Loaded docs: %@\n", objects);
        
        [self loadDocsFromDatastore];
        [self.tableView reloadData];
    } else if ([objectLoader.resourcePath hasSuffix:@"/doc_templates.json"]) {
        NSLog(@"Loaded doc templates: %@\n", objects);

        NSString *resourcePath = [NSString stringWithFormat:@"/projects/%@/docs.json",
                                  self.project.identifier];
        
        [[RKObjectManager sharedManager] loadObjectsAtResourcePath:resourcePath
                                                       objectClass:[Doc class] 
                                                          delegate:self];
    }
}

- (void)loadDocsFromDatastore {
    [_docTemplates release];
    _docTemplates = [[[_project.docTemplates allObjects] sortedArrayUsingSelector:@selector(name)] retain];
    
    [_docsByTemplate release];
    _docsByTemplate = [[NSMutableDictionary alloc] initWithCapacity:[_docTemplates count]];
    
    for (DocTemplate *tmpl in _docTemplates) {
        NSArray *docs = [[tmpl.docs allObjects] sortedArrayUsingSelector:@selector(position)];
        
        [_docsByTemplate setValue:docs forKey:[tmpl.identifier stringValue]];
    }
    
    [_docsByTemplate retain];
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error {
    NSLog(@"Error loading docs in project %@: %@\n", self.project.identifier, error);
}

- (void)objectLoaderDidLoadUnexpectedResponse:(RKObjectLoader *)objectLoader {
    NSLog(@"Got unexpected response: %@\n", [objectLoader response]);
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_docTemplates == nil)
        return 0;
    else
        return [_docTemplates count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_docTemplates == nil)
        return 0;
    
    DocTemplate *tmpl = [_docTemplates objectAtIndex:section];    
    return [tmpl.docs count];
}

- (Doc *)docForIndexPath:(NSIndexPath *)indexPath {
    DocTemplate *tmpl = [_docTemplates objectAtIndex:[indexPath indexAtPosition:0]];
    return [[_docsByTemplate objectForKey:[tmpl.identifier stringValue]] objectAtIndex:[indexPath indexAtPosition:1]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Doc *doc = [self docForIndexPath:indexPath];
    NSString *CellIdentifier = [doc.identifier stringValue];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    [[cell textLabel] setText:[doc name]];
    [[cell detailTextLabel] setText:[doc blurb]];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    // Configure the cell...
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section  {
    
    return [[_docTemplates objectAtIndex:section] name];
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
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Doc *doc = [self docForIndexPath:indexPath];
    doc.project = _project;
    self.detailViewController.doc = doc;
    [self.detailViewController reloadDoc];
}

@end
