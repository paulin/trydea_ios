//
//  TryDeaForgotPassword.h
//  tryDea
//
//  Created by Xenia Hertzenberg on 4/27/12.
//  Copyright (c) 2012 Feline Infinity. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TryDeaForgotPassword :UIViewController<UIWebViewDelegate>{
	UIWebView* forgotPasswordWebview;
	UIActivityIndicatorView *activityIndicator;
}

@property (retain, nonatomic) IBOutlet UIWebView* forgotPasswordWebview;
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@end
