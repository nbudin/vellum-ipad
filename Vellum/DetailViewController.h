//
//  DetailViewController.h
//  Vellum for iPad
//
//  Created by Nathaniel Budin on 6/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>
#import "Doc.h"

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate, UITableViewDelegate, UITableViewDataSource, RKObjectLoaderDelegate> {
    
    UIToolbar *_toolbar;
    UIBarButtonItem *_navigatorButton;
    UITableView *_tableView;
    
    Doc *_doc;
}

@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) Doc *doc;

-(void)reloadDoc;
-(void)loadDocFromDatastore;

@end
