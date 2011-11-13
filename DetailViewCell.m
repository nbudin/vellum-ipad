//
//  DetailViewCell.m
//  Vellum for iPad
//
//  Created by Nat Budin on 10/31/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "DetailViewCell.h"

@implementation DetailViewCell

@synthesize webView=_webView;

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    [self setNeedsDisplay];
}

-(int) scrollHeight {
    return [[_webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.scrollHeight"] intValue];
}

@end
