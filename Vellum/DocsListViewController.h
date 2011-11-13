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
#import "AuthenticatedTableViewController.h"

@interface DocsListViewController : AuthenticatedTableViewController {
    NSDictionary *_docsByTemplate;
    NSArray *_docTemplates;
}

@property (nonatomic, assign) Project *project;

-(Doc *)docForIndexPath:(NSIndexPath *)indexPath;

@end
