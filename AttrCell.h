//
//  AttrCell.h
//  Vellum for iPad
//
//  Created by Nathaniel Budin on 6/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewCell.h"
#import "Attr.h"

@interface AttrCell : DetailViewCell <UIWebViewDelegate>

@property (nonatomic, retain) IBOutlet UILabel *attrNameLabel;
@property (nonatomic, retain) Attr *attr;

@end
