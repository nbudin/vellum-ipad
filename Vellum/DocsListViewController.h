//
//  DocsListViewController.h
//  Vellum for iPad
//
//  Created by Nathaniel Budin on 6/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>
#import "Project.h"
#import "Doc.h"
#import "DocTemplate.h"
#import "DetailViewController.h"

@interface DocsListViewController : UITableViewController<RKObjectLoaderDelegate> {
    NSDictionary *_docsByTemplate;
    NSArray *_docTemplates;
}

@property (nonatomic, assign) Project *project;
@property (nonatomic, assign) DetailViewController *detailViewController;

-(void)reloadDocs;
-(Doc *)docForIndexPath:(NSIndexPath *)indexPath;
-(void)loadDocsFromDatastore;

@end
