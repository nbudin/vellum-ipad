//
//  DocCell.h
//  Vellum for iPad
//
//  Created by Nathaniel Budin on 6/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Doc.h"

@interface DocCell : UITableViewCell

@property (nonatomic, retain) Doc *doc;
@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UILabel *blurbLabel;

@end
