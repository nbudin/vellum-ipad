//
//  ProjectCell.m
//  Vellum for iPad
//
//  Created by Nathaniel Budin on 6/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ProjectCell.h"

@implementation ProjectCell

@synthesize project=_project;

-(void)setProject:(Project *)project {
    _project = project;
    self.textLabel.text = project.name;
    self.textLabel.font = [UIFont boldSystemFontOfSize:20.0];
    [self.textLabel setNeedsDisplay];
}

/*- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}*/

@end
