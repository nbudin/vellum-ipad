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

@interface LoginViewController : UIViewController<UIWebViewDelegate, UITextFieldDelegate> {
    
    IBOutlet UITextField *email;
    IBOutlet UITextField *password;
    IBOutlet UIWebView *webView;
    IBOutlet UINavigationController *navigationController;
    UILabel *loginLabelTop;
    UILabel *loginLabelBottom;
    UIView *loginForm;
    UIActivityIndicatorView *activityIndicator;
    id<SugarPondLoginDelegate> loginDelegate;
}
- (IBAction)login;
@property (nonatomic, retain) IBOutlet UILabel *loginLabelTop;
@property (nonatomic, retain) IBOutlet UILabel *loginLabelBottom;
@property (nonatomic, retain) IBOutlet UIView *loginForm;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (nonatomic, assign) UINavigationController *navigationController;
@property (nonatomic, assign) id<SugarPondLoginDelegate> loginDelegate;

@end
