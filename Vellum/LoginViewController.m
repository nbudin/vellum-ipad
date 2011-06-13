//
//  LoginViewController.m
//  Vellum for iPad
//
//  Created by Nat Budin on 6/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LoginViewController.h"
#import <RestKit/Support/RKJSONParser.h>
#import <QuartzCore/CAGradientLayer.h>

@implementation LoginViewController

@synthesize loginLabelTop;
@synthesize loginLabelBottom;
@synthesize loginForm;
@synthesize progressLabel;
@synthesize activityIndicator;
@synthesize loginDelegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // custom init
    }
    return self;
}

- (void)dealloc
{
    [email release];
    [password release];
    [webView release];
    [webView release];
    [loginLabelTop release];
    [loginLabelBottom release];
    [loginForm release];
    [activityIndicator release];
    [progressLabel release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CAGradientLayer *layer = [[CAGradientLayer alloc] init];
    [layer autorelease];
    
    layer.colors = [NSArray arrayWithObjects:
                    (id)[[UIColor colorWithRed:1.0 green:1.0 blue:0.5 alpha:1.0] CGColor],
                    (id)[[UIColor whiteColor] CGColor],
                    nil];
    
    layer.locations = [NSArray arrayWithObjects:
                       [NSNumber numberWithFloat:0.0],
                       [NSNumber numberWithFloat:1.0],
                       nil];
    
    layer.frame = self.view.layer.bounds;
    layer.zPosition = -100.0;
    [self.view.layer addSublayer:layer];
    
    loginLabelBottom.font = [UIFont fontWithName:@"Liberation Serif" size:24.0];
    loginLabelTop.font = [UIFont fontWithName:@"Liberation Serif" size:24.0];
    
    [activityIndicator stopAnimating];
}

- (void)viewDidUnload
{
    [email release];
    email = nil;
    [password release];
    password = nil;
    [webView release];
    webView = nil;
    [webView release];
    webView = nil;
    [self setLoginLabelTop:nil];
    [self setLoginLabelBottom:nil];
    [self setLoginForm:nil];
    [self setActivityIndicator:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (IBAction)login {
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://vellum.aegames.org/people/sign_in"]]];
    
    progressLabel.text = @"Connecting to Vellum...";
    [UIView animateWithDuration:0.25 
                     animations:^{
                         loginForm.alpha = 0.0;
                         progressLabel.hidden = false;
                     } 
     
                     completion:^(BOOL finished) {
                         [activityIndicator startAnimating];
                     }];
}

- (void) webViewDidFinishLoad:(UIWebView *)wv {
    NSURL *url = [[wv request] URL];
    NSLog(@"Finished loading %@\n", url);
    
    if ([[url host] isEqualToString:@"vellum.aegames.org"]) {
        [activityIndicator stopAnimating];
        progressLabel.text = @"";
        progressLabel.hidden = true;
        [progressLabel setNeedsDisplay];
        
        [loginDelegate loginSucceeded];
    } else if ([[url host] isEqualToString:@"accounts.sugarpond.net"]) {
        RKJSONParser *parser = [RKJSONParser new];
        
        progressLabel.text = @"Logging in...";
        [progressLabel setNeedsDisplay];
        
        NSString *jsonEmail = [parser stringFromObject:[email text]];
        NSString *jsonPassword = [parser stringFromObject:[password text]];
        
        NSString *formJavaScript = [NSString
                                    stringWithFormat:@"document.getElementById('person_email').value = %@; \
                                    document.getElementById('person_password').value = %@; \
                                    document.getElementsByTagName('form')[0].submit();",
                                    jsonEmail, jsonPassword];
        
        [webView stringByEvaluatingJavaScriptFromString:formJavaScript];
    }
}

- (void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [activityIndicator stopAnimating];
    
    [UIView animateWithDuration:0.25 
                     animations:^{
                         loginForm.alpha = 1.0;
                     }];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    if (textField == password) {
        [password resignFirstResponder];
        [self login];
        return NO;
    } else if (textField == email) {
        [password becomeFirstResponder];
        return NO;
    } else {
        return YES;
    }
}
@end
