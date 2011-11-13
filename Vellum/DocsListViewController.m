//
//  DocsListViewController.m
//  Vellum for iPad
//
//  Created by Nathaniel Budin on 6/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DocsListViewController.h"
#import "DocCell.h"

@implementation DocsListViewController

@synthesize project=_project;

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)loadedObjects {
    if ([objectLoader.resourcePath hasSuffix:@"/doc_templates.json"]) {
        NSString *resourcePath = [NSString stringWithFormat:@"/projects/%@/docs.json",
                                  self.project.identifier];
        [[RKObjectManager sharedManager] loadObjectsAtResourcePath:resourcePath
                                                       objectClass:[Doc class] 
                                                          delegate:self];
    } else if ([objectLoader.resourcePath hasSuffix:@"/docs.json"]) {
        // docs.json doesn't include project ID, so we'll bang it in
        // manually.
        
        for (Doc *doc in loadedObjects) {
            doc.projectId = self.project.identifier;
            doc.project = self.project;
        }
    }
    
    [super objectLoader:objectLoader didLoadObjects:loadedObjects];
}

-(void) setProject:(Project *)project {
    _project = project;
    [self reloadObjects];
}

-(void) loadObjectsFromDatastore {
    [super loadObjectsFromDatastore];
    
    _docTemplates = [self.project docTemplatesOrderedByName];
    _docsByTemplate = [[NSMutableDictionary alloc] initWithCapacity:[_docTemplates count]];
    
    for (DocTemplate *tmpl in _docTemplates) {
        [_docsByTemplate setValue:[tmpl docsOrderedByPosition] forKey:[tmpl.identifier stringValue]];
    }
}

-(NSString *)resourcePath {
    return [NSString stringWithFormat:@"/projects/%@/doc_templates.json", self.project.identifier];
}

+(Class) objectClass {
    return [DocTemplate class];
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
    DocCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DocCell"];
    cell.doc = [self docForIndexPath:indexPath];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section  {
    
    return [[_docTemplates objectAtIndex:section] name];
}

#pragma mark - Table view delegate

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"docSelected"]) {
        DetailViewController *detailViewController = segue.destinationViewController;
        detailViewController.doc = [self docForIndexPath:[self.tableView indexPathForSelectedRow]];
    }
}

@end
