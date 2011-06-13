//
//  DetailViewController.m
//  Vellum for iPad
//
//  Created by Nathaniel Budin on 6/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"
#import "Attr.h"

@implementation DetailViewController
@synthesize toolbar=_toolbar, navigatorButton=_navigatorButton, doc=_doc, tableView=_tableView;

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

- (Doc *)doc {
    return _doc;
}

-(void)reloadDoc {
    [[RKObjectManager sharedManager] getObject:_doc delegate:self];
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects {
    NSLog(@"Loaded docs %@", objects);
    [self loadDocFromDatastore];
    [self.tableView reloadData];
}

- (void)loadDocFromDatastore {
    NSNumber *identifier = _doc.identifier;
    
    [_doc release];
    _doc = [[Doc objectWithPrimaryKeyValue:identifier] retain];
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
    
    [_toolbar release];
    [_navigatorButton release];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (void)splitViewController:(UISplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)pc {
    
    NSMutableArray *items = [self.toolbar.items mutableCopy];
    [items insertObject:barButtonItem atIndex:0];
    [self.toolbar setItems:items animated:NO];
    [items release];
}

- (void)splitViewController:(UISplitViewController *)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem {
    
    NSMutableArray *items = [self.toolbar.items mutableCopy];
    [items removeObject:barButtonItem];
    [self.toolbar setItems:items animated:NO];
    [items release];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL isAttr = ([indexPath indexAtPosition:0] == 0);
    
    static NSString *CellIdentifier;
    UITableViewCellStyle style;
    if (isAttr) {
        CellIdentifier = [NSString stringWithFormat:@"attr_%d", [indexPath indexAtPosition:1]];
        style = UITableViewCellStyleValue2;
    } else {
        CellIdentifier = @"content";
        style = UITableViewCellStyleDefault;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:style reuseIdentifier:CellIdentifier] autorelease];
    }
    
    if (isAttr) {
        Attr *attr = [_doc.attrs objectAtIndex:[indexPath indexAtPosition:1]];
        [cell.textLabel setText:[attr name]];
        [cell.detailTextLabel setText:[attr value]];
    } else {
        [cell.textLabel setText:[_doc content]];
    }
    
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
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

@end
