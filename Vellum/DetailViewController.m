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
@synthesize toolbar=_toolbar, doc=_doc, docView=_docView, popoverController=_myPopoverController, activityIndicator;

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
}

- (void)loadDocFromDatastore {
    NSNumber *identifier = _doc.identifier;
    
    _doc = [Doc objectWithPrimaryKeyValue:identifier];
    NSLog(@"Loaded doc with attrs: %@", [_doc attrs]);
    
    [_docView setDoc:_doc];
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

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self.activityIndicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.activityIndicator stopAnimating];
}


@end
