//
//  UserLoginViewController.m
//  tryDea
//
//  Created by Xenia Hertzenberg on 3/26/12.
//  Copyright (c) 2012 Feline Infinity. All rights reserved.
//

#import "UserLoginViewController.h"
#import "TryDeaForgotPassword.h"
#import "TryDeaErrorCodes.h"
#import "JSON.h"
#import "AppController.h"

@implementation UserLoginViewController
@synthesize usernameField, passwordField, serverField, receivedData, tryDeaHTTP, httpErrorHappened;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self setTitle:@"Log In"];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
   	UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithTitle:@"Login" style:UIBarButtonItemStyleBordered
																			  target:self
																			  action:@selector(login:)];
	[[self navigationItem] setRightBarButtonItem:barButton];
	[barButton release];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.httpErrorHappened = NO;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.usernameField = nil;
    self.passwordField = nil;

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc
{
    [usernameField release];
    [passwordField release];
    [serverField release];
    [receivedData release];
    [tryDeaHTTP release];
}

-(IBAction)forgotPasswordClicked:(id)sender
{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please input your Trydea Server URL"
                                                      message:nil
                                                     delegate:self
                                            cancelButtonTitle:@"Cancel"
                                            otherButtonTitles:@"Continue", nil];
    
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [alert textFieldAtIndex:0].clearButtonMode = UITextFieldViewModeAlways;
    [alert textFieldAtIndex:0].text = DEFAULT_TRYDEA_URL;
    [alert textFieldAtIndex:0].textColor = [UIColor lightGrayColor];
   
    [alert show];
    [alert release];
}
-(IBAction)dismissKeyboard:(id)sender
{
    [sender resignFirstResponder];
}

-(IBAction)login:(id)sender
{
    if (![self validateUserEntries])
    {
        [TryDeaUtils showAlertWithTitle:@"Error" andMessage:@"Please correct entries in highlightd fields and try again"];
        return;
    }
    
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    NSString *serverStr = [TryDeaUtils extractURL:self.serverField.text]; 

//  [self.navigationController popViewControllerAnimated:YES];
    
    [TryDeaUtils setDefaultValue:serverStr forKey:tryDeaServerUrlVar];
    [self submitLoginRequestWithUsername:username andPassword:password andServer:serverStr];
}
-(IBAction)userStartedToEdit:(id)sender
{
    UITextField *txtField = (UITextField *)sender;
    if (txtField.text.length > 3) {
        txtField.text = @"";
    }
    
    txtField.backgroundColor = [UIColor whiteColor];
    [txtField release];
}

-(bool)validateUserEntries
{
    bool success = YES;
    
    if (self.usernameField.text.length < 2) {
        self.usernameField.backgroundColor = UIColorFromRGB(0xFF6103);
        self.usernameField.text = @"Please enter username";
        success = NO;
    }  
    if (self.passwordField.text.length < 2) {
        self.passwordField.backgroundColor = UIColorFromRGB(0xFF6103);
        self.passwordField.text = @"Please enter password";
        success = NO;

    }  

    if (self.serverField.text.length < 4 || ![TryDeaUtils validateURL:self.serverField.text]) {
        self.serverField.backgroundColor = UIColorFromRGB(0xFF6103);
       // self.serverField.text = DEFAULT_TRYDEA_URL;
        self.serverField.text = @"Please enter valid url";
        success = NO;
    }  
    return success;
}

-(void)submitLoginRequestWithUsername:(NSString* )aUsername andPassword:(NSString *)aPassword andServer:(NSString* )aServer
{
	
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults]; 
	[defaults setObject:aUsername forKey:@"username"];
	[defaults setObject:aPassword forKey:@"password"];
	NSString *serverUrl = [NSString stringWithFormat:@"%@/%@/%@", aServer, mobileGatewayAuth, getUserInfo] ;
	NSString *authHeader = [TryDeaUtils getEncodedStringForUsername:aUsername password:aPassword];
	self.tryDeaHTTP = [[TryDeaHTTP alloc]init];
	[self.tryDeaHTTP setDelegate:self];
	NSDictionary* headers = [[NSDictionary alloc] initWithObjectsAndKeys:
							 authHeader ,@"Authorization",
							 nil];
	// if there was anything in receivedData before - ciao!
	if (receivedData)
	{
		[receivedData release];
		receivedData = nil;
	}
	self.receivedData = [[NSMutableData alloc] init];
    AppController *appController = [AppController sharedAppController];
    [appController startAnimation];
    
	[tryDeaHTTP executeRequesttoUrl:serverUrl withHeaders:headers andData:nil usingMethod:httpMethodGet];

}

#pragma UIAlertView delegate methods
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1){ //"Continue button"
        NSString *trydeaServerUrl = [alertView textFieldAtIndex:0].text;
        [TryDeaUtils setDefaultValue:trydeaServerUrl forKey:tryDeaServerUrlVar];
        TryDeaForgotPassword *fpVc = [[TryDeaForgotPassword alloc]init];
        [[self navigationController] pushViewController:fpVc animated:YES];
        [fpVc release];
    }
}

- (BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView
{
    NSString *url = [[alertView textFieldAtIndex:0] text];
    return [TryDeaUtils validateURL:url];
    
}

#pragma mark NSURLConnection delegate methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [receivedData setLength:0];
    NSInteger httpStatus = [((NSHTTPURLResponse *)response) statusCode];
    NSLog(@"responsecode:%d", httpStatus);
    // there will be various HTTP response code (status)
    // you might concern with 404
    if(httpStatus > 205) //some sort of error :-(
    {
        self.httpErrorHappened = YES;
        AppController *appController = [AppController sharedAppController];
        [appController stopAnimation];
        
        if (httpStatus == FAILURE_401) {
            [TryDeaUtils showAlertWithTitle:@"Error" andMessage:@"Could not login with provided credentials"];
        }else
        {
            NSString *serverStr = [TryDeaUtils defaultValueForKey:tryDeaServerUrlVar];
            [TryDeaUtils showAlertWithTitle:@"Server error" andMessage:ERROR_MESSAGE_WRONG_SERVER(serverStr)];
        }
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	NSLog(@"Received %d bytes of data (I am in User Loginr)", [data length]); 
	
	[receivedData appendData:data];
	NSLog(@"Received data is now %d bytes (I am in User Login)", [receivedData length]); 
	
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	NSLog(@"Error receiving response (I am in User Login): %@", [error localizedDescription]);
	//[[NSAlert alertWithError:error] runModal];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    if (httpErrorHappened) {
        httpErrorHappened = NO;
        return; // no point processing the repsponse - it's not going to be good
    }
	// Once this method is invoked, "responseData" contains the complete result
	NSString *serverResponse=[[NSString alloc] initWithData:receivedData encoding:NSASCIIStringEncoding];
	if (![TryDeaUtils validateJSON:serverResponse]) {
        [TryDeaUtils logOut];
        NSString *serverUrl = [TryDeaUtils defaultValueForKey:tryDeaServerUrlVar];
        [TryDeaUtils showAlertWithTitle:@"Could not login" andMessage:ERROR_MESSAGE_WRONG_SERVER(serverUrl)];
    }
    
    
	AppController *appController = [AppController sharedAppController];
    [appController stopAnimation];
    NSLog(@"Returned Response: %@", serverResponse);
    SBJsonParser *parser = [[SBJsonParser alloc]init];
    NSError *error = nil;
		
    @try{ 
        NSDictionary *parsedResponse =[parser objectWithString:serverResponse error:&error];
        NSString *status =[parsedResponse objectForKey:@"status" ];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if ([status isEqualToString:@"success"]) 
        {
            [defaults setObject:LOGGEDIN forKey:@"status"];	
            // TODO: into Constants
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SuccessfulLogin" object:self];
            [self.navigationController popViewControllerAnimated:YES];
        
        }else {			
            //TODO: refactor into method
            [TryDeaUtils logOut];
            UIAlertView *alert = [[UIAlertView alloc]
									  initWithTitle: @"Login Failed!"
									  message: @"Could not log in with credentials provided"
									  delegate: nil
									  cancelButtonTitle:@"OK"
									  otherButtonTitles:nil];
            [alert show];
            [alert release];		
        }
    }@catch(NSException * e){
        NSLog(@"Parser could not parse this response, error %@", [error localizedDescription]);
        NSLog(@"Exception reads: %@", [e description]);
        [TryDeaUtils logOut];
        UIAlertView *alert = [[UIAlertView alloc]
								  initWithTitle: @"Login Failed!"
								  message: @"Could not log in with credentials provided"
								  delegate: nil
								  cancelButtonTitle:@"OK"
								  otherButtonTitles:nil];
        [alert show];
        [alert release];	
            
    }@finally {
        [parser release];
        [tryDeaHTTP release];
    }
	
	[serverResponse release];
}


@end
