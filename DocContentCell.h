//
//  DocContentCell.h
//  Vellum for iPad
//
//  Created by Nathaniel Budin on 6/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Doc.h"
#import "DetailViewCell.h"

@interface DocContentCell : DetailViewCell

@property (nonatomic, retain) Doc *doc;

@end
