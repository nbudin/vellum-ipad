//
//  LoginViewController.h
//  Vellum for iPad
//
//  Created by Nat Budin on 6/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>
#import "SugarPondLoginDelegate.h"
#import <Accounts/Accounts.h>

extern NSString *SugarPondLoginCompleted;
extern NSString *SugarPondLoginFailed;

@interface SugarPondLoginViewController : UIViewController<UIWebViewDelegate, UITextFieldDelegate> {
    
    IBOutlet UITextField *email;
    IBOutlet UITextField *password;
    IBOutlet UIWebView *webView;
    UILabel *loginLabelTop;
    UILabel *loginLabelBottom;
    UILabel *progressLabel;
    UIView *loginForm;
    UIActivityIndicatorView *activityIndicator;
    id<SugarPondLoginDelegate> __unsafe_unretained loginDelegate;
}
+ (SugarPondLoginViewController *)sharedInstance;
- (IBAction)login;
+ (BOOL) loggedIn;

@property (nonatomic, retain) IBOutlet UILabel *loginLabelTop;
@property (nonatomic, retain) IBOutlet UILabel *loginLabelBottom;
@property (nonatomic, retain) IBOutlet UILabel *progressLabel;
@property (nonatomic, retain) IBOutlet UIView *loginForm;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, assign) IBOutlet id<SugarPondLoginDelegate> loginDelegate;

@end
