//
//  DocViewController.h
//  Vellum for iPad
//
//  Created by Nathaniel Budin on 6/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DocViewController : UITableViewController<UISplitViewControllerDelegate, UIPopoverControllerDelegate> {
    
    UIToolbar *_toolbar;
}

@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;

@end
