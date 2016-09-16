//
//  TryDeaSettingsViewController.m
//  tryDea
//
//  Created by Xenia Hertzenberg on 3/29/12.
//  Copyright (c) 2012 Feline Infinity. All rights reserved.
//

#import "TryDeaSettingsViewController.h"
#import "UserLoginViewController.h"
#import "RegisterNewViewController.h"


@interface TryDeaSettingsViewController(Private)
    -(void)logOff;
@end

@implementation TryDeaSettingsViewController

@synthesize registerNewButton, loginButton;


-(id)init
{
    UITabBarItem *tbi = [self tabBarItem];
	[tbi setTitle:@"Settings"];
	[tbi setImage:[UIImage imageNamed:@"settings_white.png"]];
    [self setTitle:@"Settings"];
    return self;
    
}

-(IBAction)loginButtonClicked:(id)sender
{
    [self statusChanged:nil];
}
-(IBAction)registerNewButtonClicked:(id)sender
{
    RegisterNewViewController *registerNewViewController = [[RegisterNewViewController alloc] initWithNibName:@"RegisterNewViewController" bundle:nil];
    // Pass the selected object to the new view controller.		
    [self.navigationController pushViewController:registerNewViewController animated:YES];
    NSLog(@"Nav Controller: %@", [self.navigationController description]);
    [registerNewViewController release];   
}
- (IBAction) statusChanged:(id)sender
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSString *userStatus = [defaults objectForKey:@"status"];
	if ([userStatus isEqualToString:LOGGEDIN]) 
	{
		NSString *msg = [NSString stringWithFormat:@"Log off user %@?", [TryDeaUtils defaultValueForKey:@"username"]];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Logging off" message:msg delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Log Off",nil];
        [alert show];
        [alert release];
	}else{
		
        UserLoginViewController *userLoginViewController = [[UserLoginViewController alloc] initWithNibName:@"UserLoginViewController" bundle:nil];
		// Pass the selected object to the new view controller.		
		[self.navigationController pushViewController:userLoginViewController animated:YES];
		[userLoginViewController release];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    // user canceled attempt to log off
    if (buttonIndex == 0) {
        return;
    }else
    {
        [self logOff];
    }
}
-(void) logOff
{
   
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];    
    [defaults setObject:@"" forKey:@"username"];
    [defaults setObject:@"" forKey:@"password"];
	[defaults setObject:LOGGEDOUT forKey:@"status"];
    [self changeLoginButtonTitle];
    [[NSNotificationCenter defaultCenter] postNotificationName:LOGOFF_NOTIFICATION object:self];

}

-(void)changeLoginButtonTitle
{
    if ([[TryDeaUtils defaultValueForKey:@"status"] isEqualToString:LOGGEDIN]) {
        NSString *username = [TryDeaUtils defaultValueForKey:@"username"];
        NSString *title = [NSString stringWithFormat:@"User %@ logged in", username];
        [self.loginButton setTitle:title forState:UIControlStateNormal];
        [self.loginButton setTitle:title forState:UIControlStateSelected];
        [self.loginButton setTitle:title forState:UIControlStateHighlighted];
    }else
    {
        [self.loginButton setTitle:@"User not logged in" forState:UIControlStateNormal];
        [self.loginButton setTitle:@"User not logged in" forState:UIControlStateSelected];
        [self.loginButton setTitle:@"User not logged in" forState:UIControlStateHighlighted];
    }
}

#pragma lifecycle methods
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLoginButtonTitle) name:@"SuccessfulLogin" object:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self changeLoginButtonTitle];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [loginButton release];
    [registerNewButton release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

@end
