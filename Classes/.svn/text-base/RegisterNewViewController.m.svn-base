//
//  RegisterNewController.m
//  tryDea
//
//  Created by Xenia Hertzenberg on 7/18/11.
//  Copyright 2011 Xenia H. All rights reserved.
//

#import "RegisterNewViewController.h"
//#import "JSON.h"
#import "TryDeaUtils.h"
#import "Constants.h"

@implementation RegisterNewViewController

@synthesize  serverUrlField, signupCodeField, emailField, usernameField, passwordField, passConfirmField, scrollView, originalScrollPoint, activeField;

-(id)init
{
	self = [super init];
	if (self)
	{
		[self setTitle:@"Register"];		
	}
	
	return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
	
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithTitle:@"Register" style:UIBarButtonItemStyleBordered
                                                                  target:self action:@selector(registerNewAccount:)];
    [[self navigationItem] setRightBarButtonItem:barButton];
	[barButton release];
	
    
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(keyboardWillShow:) 
                                                 name:UIKeyboardWillShowNotification 
                                               object:self.view.window];
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(keyboardWillHide:) 
                                                 name:UIKeyboardWillHideNotification 
                                               object:self.view.window];
    //make contentSize bigger than your scrollSize 
   // CGSize scrollContentSize = CGSizeMake(320, 500);
    self.originalScrollPoint = self.scrollView.contentOffset;
  //  self.scrollView.contentSize = scrollContentSize;
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height-100);
    
    NSString * tentativeSignupCode = [TryDeaUtils defaultValueForKey:@"tentativeSignupCode"];
    NSString * tentativeUsername = [TryDeaUtils defaultValueForKey:@"tentativeUsername"];
    NSString * tentativeEmail = [TryDeaUtils defaultValueForKey:@"tentativeEmail"];
    NSString * tentativePassword = [TryDeaUtils defaultValueForKey:@"tentativePassword"];
    NSString * tentativePasswordConfirm = [TryDeaUtils defaultValueForKey:@"tentativePasswordConfirm"];
    NSString * tentativeServerUrl = [TryDeaUtils defaultValueForKey:@"tentativeServerUrl"];
   

    if (tentativeSignupCode && tentativeSignupCode.length > 1) {
        self.signupCodeField.text = tentativeSignupCode;
    }
    if (tentativeUsername && tentativeUsername.length > 1) {
        self.usernameField.text = tentativeUsername;
    }
    if (tentativeEmail && tentativeEmail.length > 1) {
        self.emailField.text = tentativeEmail;
    }
    
    if (tentativePassword && tentativePassword.length > 1) {
        self.passwordField.text = tentativePassword;
    }
    
    if (tentativePasswordConfirm && tentativePasswordConfirm.length > 1) {
        self.passConfirmField.text = tentativePasswordConfirm;
    }
    if (tentativeServerUrl && tentativeServerUrl.length > 1) {
        self.serverUrlField.text = tentativeServerUrl;
    }

}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (IBAction)registerNewAccount:(id)sender
{	
	NSString *signUpCode = self.signupCodeField.text;
	NSString *userName = self.usernameField.text;
	NSString *password = self.passwordField.text;
	NSString *passwordConfirm = self.passConfirmField.text;
	NSString *email = self.emailField.text;
	bool showAlert = NO;
	    
    if (self.serverUrlField.text.length < 4 || ![TryDeaUtils validateURL:self.serverUrlField.text]) {
        self.serverUrlField.backgroundColor = UIColorFromRGB(0xEFA44F);
        self.self.serverUrlField.text = DEFAULT_TRYDEA_URL;
        showAlert = YES;
    }
    
    if (signUpCode.length < 2) {
		self.signupCodeField.backgroundColor = UIColorFromRGB(0xEFA44F);
        showAlert = YES;
	}
    
    if (userName.length < 2) {
        self.usernameField.backgroundColor = UIColorFromRGB(0xEFA44F);
        showAlert = YES;

    }
    
    if (password.length < 2) {
        self.passwordField.backgroundColor = UIColorFromRGB(0xEFA44F);
        showAlert = YES;

    }
    
    if (![passwordConfirm isEqualToString:password]) {
        self.passConfirmField.backgroundColor = UIColorFromRGB(0xEFA44F);
        self.passwordField.backgroundColor = UIColorFromRGB(0xEFA44F);
        [TryDeaUtils showAlertWithTitle:@"Error" andMessage:@"Passwords are not the same! Please correct and try again"];
        return;
    }
    
    if (email.length < 2 || ![TryDeaUtils validateEmail:email]) {
        self.emailField.backgroundColor = UIColorFromRGB(0xEFA44F);
        showAlert = YES;

    }
    
	if (showAlert) {
        [TryDeaUtils showAlertWithTitle:@"Error" andMessage:@"Please correct the errors in highlighted fields, and try again"];
        return;
    }else
    {
        NSString *signUpCode = self.signupCodeField.text;
        NSString *userName = self.usernameField.text;
        NSString *password = self.passwordField.text;
        NSString *passwordConfirm = self.passConfirmField.text;
        NSString *email = self.emailField.text;
        NSString *serverUrl = [TryDeaUtils extractURL:self.serverUrlField.text];
        
        [TryDeaUtils setDefaultValue:signUpCode forKey:@"tentativeSignupCode"];
        [TryDeaUtils setDefaultValue:userName forKey:@"tentativeUsername"];
        [TryDeaUtils setDefaultValue:password forKey:@"tentativePassword"];
        [TryDeaUtils setDefaultValue:passwordConfirm forKey:@"tentativePasswordConfirm"];
        [TryDeaUtils setDefaultValue:email forKey:@"tentativeEmail"];
        [TryDeaUtils setDefaultValue:serverUrl forKey:@"tentativeServerUrl"];        
    }
	
	// reach server. If username already exists: = alert
	NSLog(@"signup code: %@, username: %@, email: %@, password: %@, password conf: %@", 
					self.signupCodeField.text, self.usernameField.text, self.emailField.text, self.passwordField.text, self.passConfirmField.text);
	
	NSString* response = nil;
	NSString *serverUrl = [TryDeaUtils extractURL:self.serverUrlField.text];

	int result = [TryDeaUtils registerNewUser:userName withPassword:password andEmail:email andSignUpCode:signUpCode toServerUrl:serverUrl returningResponse:&response];
    
	if (result == ERROR_GENERAL) {
		NSLog(@"COULD NOT REGISTER USER");
        // TODO: here I could parse received response and extract the error
        [TryDeaUtils showAlertWithTitle:@"Error" andMessage:@"Error registering user"];
        return;
    }else if(result == ERROR_WRONG_SERVER)
    {
        [TryDeaUtils showAlertWithTitle:@"Error" andMessage:ERROR_MESSAGE_WRONG_SERVER(serverUrl)];
        return;
    
	}else {
		NSString *message = [NSString stringWithFormat:@"User %@ successfully created and logged in", userName];
        [TryDeaUtils  showAlertWithTitle:@"Success!" andMessage:message];
        
        NSLog(@"RESPONSE (to new user request):%@ ", response);
        // clear out the cached values for registrant's username etc
        [TryDeaUtils setDefaultValue:@"" forKey:@"tentativeSignupCode"];
        [TryDeaUtils setDefaultValue:@"" forKey:@"tentativeUsername"];
        [TryDeaUtils setDefaultValue:@"" forKey:@"tentativePassword"];
        [TryDeaUtils setDefaultValue:@"" forKey:@"tentativePasswordConfirm"];
        [TryDeaUtils setDefaultValue:@"" forKey:@"tentativeEmail"];
        [TryDeaUtils setDefaultValue:@"" forKey:@"tentativeServerUrl"];
        
        // log out previous user, login new user
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:LOGGEDIN forKey:@"status"];	
        [defaults setObject:userName forKey:@"username"];
        [defaults setObject:password forKey:@"password"];
        [defaults setObject:serverUrl forKey:tryDeaServerUrlVar];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SuccessfulLogin" object:self];
        [self.navigationController popViewControllerAnimated:YES];
	}
}

- (IBAction)dismiss:(id)sender
{
    [sender resignFirstResponder];
}

- (void)doneWithInput
{
    [activeField resignFirstResponder];
  //  [scrollView setContentOffset:self.originalScrollPoint animated:YES];
}

-(void)jumpToNext
{
    if ([self.activeField isEqual:serverUrlField]) {
        [self.signupCodeField becomeFirstResponder];
        activeField = self.signupCodeField;
        return;
    }
    
    if ([self.activeField isEqual:signupCodeField]) {
        [self.emailField becomeFirstResponder];
        activeField = self.emailField;
        return;
    }
    
    if ([self.activeField isEqual:emailField]) {
        [self.usernameField becomeFirstResponder];
        activeField = self.usernameField;
        return;
    }
    
    if ([self.activeField isEqual:usernameField]) {
        [self.passwordField becomeFirstResponder];
        activeField = self.passwordField;
        return;
    }
    
    if ([self.activeField isEqual:passwordField]) {
        [self.passConfirmField becomeFirstResponder];
        activeField = self.passConfirmField;
        return;
    }
    
}

-(void)jumpToPrev
{
    if ([self.activeField isEqual:passConfirmField]) {
        [self.passwordField becomeFirstResponder];
        activeField = self.passwordField;
        return;
    }
    
    if ([self.activeField isEqual:passwordField]) {
        [self.usernameField becomeFirstResponder];
        activeField = self.usernameField;
        return;
    }
    
    if ([self.activeField isEqual:usernameField]) {
        [self.emailField becomeFirstResponder];
        activeField = self.emailField;
        return;
    }
    
    if ([self.activeField isEqual:emailField]) {
        [self.signupCodeField becomeFirstResponder];
        activeField = self.signupCodeField;
        return;
    }
    
    if ([self.activeField isEqual:signupCodeField]) {
        [self.serverUrlField becomeFirstResponder];
        activeField = self.serverUrlField;
        return;
    }
}

#pragma keyboard notification responses

- (void)keyboardWillHide:(NSNotification *)n
{
}

- (void)keyboardWillShow:(NSNotification *)n
{
 [self.scrollView adjustOffsetToIdealIfNeeded];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{	
    // construct the custom keyboard for the input
    self.activeField = textField;
    UIToolbar *toolbar = [[[UIToolbar alloc] init] autorelease];
	[toolbar setBarStyle:UIBarStyleBlackTranslucent];
	[toolbar sizeToFit];
	
	UIBarButtonItem *flexButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIBarButtonItem *prevButton = [[UIBarButtonItem alloc] initWithTitle:@"Prev" style:UIBarButtonItemStyleBordered target:self action:@selector(jumpToPrev)];
    
    UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStyleBordered target:self action:@selector(jumpToNext)];
    
    if(textField == self.serverUrlField){
        [prevButton setEnabled:NO];
    }else if(textField == self.passConfirmField)
    {
        [nextButton setEnabled:NO];
    }else
    {
        
    }
    
	UIBarButtonItem *doneButton =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneWithInput)];
	
	NSArray *itemsArray = [NSArray arrayWithObjects:prevButton, nextButton, flexButton, doneButton, nil];
	
	[flexButton release];
	[doneButton release];
    [prevButton release];
    [nextButton release];
	[toolbar setItems:itemsArray];
    [textField setInputAccessoryView:toolbar];

    textField.backgroundColor = [UIColor whiteColor];
    if (textField == self.passwordField) {
        self.passConfirmField.backgroundColor = [UIColor whiteColor];
    }
    if (textField == self.passConfirmField) {
        self.passwordField.backgroundColor = [UIColor whiteColor];
        
    }
  //  [scrollView adjustOffsetToIdealIfNeeded];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    activeField = nil;
    [self keyboardWillHide:nil];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.serverUrlField = nil;
    self.usernameField = nil;
    self.passwordField = nil;
    self.passConfirmField = nil;
    self.signupCodeField = nil;
    self.emailField = nil;
    self.scrollView = nil;
    
   // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self 
                                                    name:UIKeyboardWillShowNotification 
                                                  object:nil]; 
    
    [[NSNotificationCenter defaultCenter] removeObserver:self 
                                                    name:UIKeyboardWillHideNotification 
                                                  object:nil]; 
}


- (void)dealloc {
    [scrollView release];
    [serverUrlField release];
    [usernameField release];
    [passConfirmField release];
    [passwordField release];
    [signupCodeField release];
    [emailField release];
    [super dealloc];
}


@end
