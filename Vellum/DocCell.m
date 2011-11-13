//
//  DocCell.m
//  Vellum for iPad
//
//  Created by Nathaniel Budin on 6/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DocCell.h"

@implementation DocCell

@synthesize doc=_doc, nameLabel, blurbLabel;

-(void)setDoc:(Doc *)doc {
    nameLabel.text = doc.name;
    blurbLabel.text = doc.blurb;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    if (selected) {
        nameLabel.textColor = [UIColor whiteColor];
        blurbLabel.textColor = [UIColor whiteColor];
    } else {
        nameLabel.textColor = [UIColor blackColor];
        blurbLabel.textColor = [UIColor lightGrayColor];
    }
}

@end
