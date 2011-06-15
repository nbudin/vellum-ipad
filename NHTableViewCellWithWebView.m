// Copyright (c) 2010 Sirrahsoft LLC
// 
// Permission is hereby granted, free of charge, to any person
// obtaining a copy of this software and associated documentation
// files (the "Software"), to deal in the Software without
// restriction, including without limitation the rights to use,
// copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the
// Software is furnished to do so, subject to the following
// conditions:
// 
// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
// OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
// HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
// WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
// OTHER DEALINGS IN THE SOFTWARE.
//
//  NHTableViewCellWithWebView.m
//  FastTableViewCellWithWebView
//
//  Created by Nick Harris on 6/16/10.
//  Copyright 2010 Sirrahsoft LLC. All rights reserved.
//

#import "NHTableViewCellWithWebView.h"

#define kEventTextX           10
#define kEventTextY           10
#define kEventTextMaxWidth    300
#define kEventTextMaxHeight   100

NSString* NHTableViewCellWithWebViewHtmlTemplate = @"\
<html>\
<head>\
<style type=\"text/css\">\
body { webkit-user-select:none;\
word-wrap:break-word;\
margin: 0px 0px 0px 0px;\
font-family: Helvetica;\
background-color:transparent;\
color: black;\
font-size: 14px;\
font-weight:bold;\
color:#444444 }\
a:link {color: #3C91BA;}\
a:visited {color: #3C91BA;}\
a:active {color: #3C91BA;}\
a {text-decoration: none;}\
</style>\
</head>\
<body>%@</body>\
</html>\
";

@interface NHTableViewCellWithWebView ()
-(void) addWebView;
-(void) removeWebView;
-(CGSize) getSizeForEventText;
@end

@implementation NHTableViewCellWithWebView

@synthesize eventText, eventHtml;

static UIFont *eventTextFont = nil;
static UIImage *gradiant = nil;

+ (void)initialize
{
	eventTextFont = [UIFont boldSystemFontOfSize:14];
	gradiant = [UIImage imageNamed:@"gradient.png"];
}

+(CGFloat)staticCellHeight
{
	return 120;
}

-(void) setEventText:(NSString *)s
{
	[eventText release];
	eventText = [s copy];
	[self setNeedsDisplay];
}

-(void) setEventHtml:(NSString *)s
{
	[eventHtml release];
	eventHtml = nil;
	
	if(s)
	{
		eventHtml = [[NSString stringWithFormat:NHTableViewCellWithWebViewHtmlTemplate, s] retain];
	}
	else 
	{
		[self removeWebView];
	}
}

-(void) addWebView
{
	if(eventHtml)
	{
		CGSize eventTextSize = [self getSizeForEventText];
		if(!webView)
		{
			webView = [[[UIWebView alloc] initWithFrame:CGRectMake(kEventTextX, kEventTextY, eventTextSize.width+1, eventTextSize.height)]retain];
			[self addSubview:webView];
			webView.hidden = YES;
			webView.backgroundColor = [UIColor clearColor];
			webView.opaque = NO;
			webView.delegate = self;
		}
		else
			webView.frame = CGRectMake(kEventTextX, kEventTextY, eventTextSize.width+1, eventTextSize.height);
		
		[webView loadHTMLString:eventHtml baseURL:nil];
	}
}

-(void) removeWebView
{
	if(webView)
	{
		// very important to set the delegate to nil.  Not doing so will cause crashes
		webView.delegate = nil;
		[webView resignFirstResponder];
		[webView removeFromSuperview];
		[webView release];
	}
	webView = nil;
	[self setNeedsDisplay];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
	if(navigationType == UIWebViewNavigationTypeOther)
		return YES;
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Link!" message:@"You touched a link!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
	[alert release];
	
	return NO;
}

-(void)_showWebView
{
	webView.hidden = NO;
	[self setNeedsDisplay];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
	if(eventHtml)
		[self performSelector:@selector(_showWebView) withObject:nil afterDelay:.35];  
}

-(void)prepareForReuse
{
	[self removeWebView];
	[super prepareForReuse];
}

-(CGSize)getSizeForEventText
{
	CGSize maxEventStringSize = CGSizeMake(kEventTextMaxWidth, kEventTextMaxWidth);
	return [eventText sizeWithFont:eventTextFont constrainedToSize:maxEventStringSize lineBreakMode:UILineBreakModeTailTruncation];
}

- (void)drawContentView:(CGRect)r
{
	CGContextRef context = CGContextRetain(UIGraphicsGetCurrentContext());
	self.clipsToBounds = true;
	
	UIColor *backgroundColor = [UIColor whiteColor];
	[backgroundColor set];
	CGContextFillRect(context, r);
	
	[gradiant drawInRect:r];
	if((webView)&&(!webView.hidden))
		[[UIColor clearColor] set];
	else
		[[UIColor colorWithWhite:0.3 alpha:1.0] set];
	
	
	CGSize eventTextSize = [self getSizeForEventText];
	CGRect eventTextRect = CGRectMake(kEventTextX, kEventTextY, eventTextSize.width, eventTextSize.height);
	[eventText drawInRect:eventTextRect withFont:eventTextFont lineBreakMode:UILineBreakModeTailTruncation alignment:UITextAlignmentLeft];
	
	CGContextRelease(context);
}

-(void)dealloc
{
	[super dealloc];
	[self removeWebView];
	[eventText release];
	[eventHtml release];
}

@end
