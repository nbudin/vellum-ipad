//
//  AttrCell.m
//  Vellum for iPad
//
//  Created by Nathaniel Budin on 6/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AttrCell.h"

@implementation AttrCell

@synthesize attr=_attr, attrNameLabel=_attrNameLabel, webView=_webView;

-(void)setAttr:(Attr *)attr {
    _attr = attr;
    
    self.attrNameLabel.text = attr.name;
    [self.webView loadHTMLString:attr.value baseURL:nil];
}

-(void)layoutSubviews {
    CGRect webViewFrame = self.webView.frame;
    webViewFrame.size.width = self.frame.size.width - webViewFrame.origin.x - self.frame.origin.x - 10;
    //[self.webView setFrame:webViewFrame];
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
