//
//  DetailViewCell.h
//  Vellum for iPad
//
//  Created by Nat Budin on 10/31/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewCell : UITableViewCell <UIWebViewDelegate>

@property (nonatomic, retain) IBOutlet UIWebView *webView;

-(int) scrollHeight;

@end
