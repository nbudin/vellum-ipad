//
//  DetailViewController.m
//  Vellum for iPad
//
//  Created by Nathaniel Budin on 6/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"
#import "Attr.h"
#import "AttrCell.h"
#import "DocContentCell.h"

@interface DetailViewController ()
@property (strong, nonatomic) UIPopoverController *popoverController;
- (void)configureView;
@end

@implementation DetailViewController
@synthesize toolbar=_toolbar, doc=_doc, tableView=_tableView, popoverController=_myPopoverController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
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

-(void)setDoc:(Doc *)doc {
    _doc = doc;
    [self reloadDoc];
}

-(void)reloadDoc {
    if (self.doc != nil) {
        NSLog(@"Doc ID %@, project ID %@", self.doc.identifier, self.doc.project.identifier);
        [[RKObjectManager sharedManager] getObject:self.doc delegate:self];
    }
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects {
    NSLog(@"Loaded docs %@", objects);
    [self loadDocFromDatastore];
    [self.tableView reloadData];
}

- (void)loadDocFromDatastore {
    NSNumber *identifier = _doc.identifier;
    
    _doc = [Doc objectWithPrimaryKeyValue:identifier];
    NSLog(@"Loaded doc with attrs: %@", [_doc attrs]);
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad]; 
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (void)splitViewController:(UISplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)pc {
    
    NSMutableArray *items = [self.toolbar.items mutableCopy];
    [items insertObject:barButtonItem atIndex:0];
    [self.toolbar setItems:items animated:YES];
    self.popoverController = pc;
}

- (void)splitViewController:(UISplitViewController *)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem {
    
    NSMutableArray *items = [self.toolbar.items mutableCopy];
    [items removeObject:barButtonItem];
    [self.toolbar setItems:items animated:YES];
    self.popoverController = nil;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_doc == nil)
        return 0;
    else
        return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_doc == nil)
        return 0;
    
    if (section == 0)
        return [_doc.attrs count];
    else
        return 1;
}

- (DetailViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL isAttr = ([indexPath indexAtPosition:0] == 0);
    
    if (isAttr) {
        AttrCell *attrCell = [tableView dequeueReusableCellWithIdentifier:@"AttrCell"];
        attrCell.attr = [self.doc.attrs objectAtIndex:[indexPath indexAtPosition:1]];
        return attrCell;
    } else {
        DocContentCell *docContentCell = [tableView dequeueReusableCellWithIdentifier:@"DocContentCell"];
        docContentCell.doc = self.doc;
        return docContentCell;
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailViewCell *cell = (DetailViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    CGFloat desiredHeight = [cell scrollHeight] + cell.webView.frame.origin.y * 2;
    
    if (desiredHeight > 38)
        return desiredHeight;
    else
        return 38;
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

@end
