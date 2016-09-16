//
//  RegisterNewController.h
//  tryDea
//
//  Created by Xenia Hertzenberg on 7/18/11.
//  Copyright 2011 Xenia H. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPKeyboardAvoidingScrollView.h"


@interface RegisterNewViewController : UIViewController<UITextFieldDelegate> {
    UITextField                             *serverUrlField;
	UITextField                             *signupCodeField;
	UITextField                             *emailField;
	UITextField                             *usernameField;
	UITextField                             *passwordField;
	UITextField                             *passConfirmField;
    
    TPKeyboardAvoidingScrollView *scrollView;
    CGPoint originalScrollPoint;
	UITextField *activeField;
    
    bool keyboardIsShown;
   
}

@property (nonatomic, retain) IBOutlet  UITextField *serverUrlField;
@property (nonatomic, retain) IBOutlet  UITextField *signupCodeField;
@property (nonatomic, retain) IBOutlet  UITextField *emailField;
@property (nonatomic, retain) IBOutlet  UITextField *usernameField;
@property (nonatomic, retain) IBOutlet  UITextField *passwordField;
@property (nonatomic, retain) IBOutlet  UITextField *passConfirmField;
@property (nonatomic, assign) CGPoint originalScrollPoint;
@property (nonatomic, retain) IBOutlet UITextField *activeField;

@property (nonatomic, retain) IBOutlet TPKeyboardAvoidingScrollView *scrollView;

- (IBAction)dismiss:(id)sender;
- (IBAction)registerNewAccount:(id)sender;
-(void)jumpToPrev;
-(void)jumpToNext;
- (void)doneWithInput;
//- (bool) validateEmail:(NSString *)candidate;

@end
