//
//  TryDeaForgotPassword.m
//  tryDea
//
//  Created by Xenia Hertzenberg on 4/27/12.
//  Copyright (c) 2012 Feline Infinity. All rights reserved.
//

#import "TryDeaForgotPassword.h"
#import "TryDeaUtils.h"
#import "Constants.h"

@implementation TryDeaForgotPassword
@synthesize forgotPasswordWebview, activityIndicator;

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
    [super viewDidLoad];
    //	NSString *urlAddress = [NSString stringWithFormat:@"%@/%@/%@", [TryDeaUtils defaultValueForKey:tryDeaServerUrlVar], mobileGatewayOpen, forgotPassword];
	NSString *urlAddress = [NSString stringWithFormat:@"%@/%@", [TryDeaUtils defaultValueForKey:tryDeaServerUrlVar], forgotPassword];
    
    
	//Create a URL object.
	NSURL *url = [NSURL URLWithString:urlAddress];
	//URL Requst Object
	NSURLRequest *request = [NSURLRequest requestWithURL:url];
	//Load the request in the UIWebView.
	forgotPasswordWebview.delegate = self;
	[forgotPasswordWebview loadRequest:request];	
	
	//activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
	//activityIndicator.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
	//activityIndicator.center = self.view.center;
    //activityIndicator.hidden = YES;
	//[self.view addSubview: activityIndicator];
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

#pragma webView delegate
#pragma mark WEBVIEW Methods

- (void)webViewDidStartLoad:(UIWebView *)webView
{
	// starting the load, show the activity indicator in the status bar
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	[activityIndicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
	// finished loading, hide the activity indicator in the status bar
    NSLog(@"Did finish load");
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	[activityIndicator stopAnimating];
    activityIndicator.hidden = YES;
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"Did fail load");
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	
	// TODO: show an alert instead?
	NSString* errorString = [NSString stringWithFormat:
							 @"<html><center><br /><br /><font size=+3 color='blue'>Error<br /><br />Could not process your request: %@</font></center></html>",
							 error.localizedDescription];
	[forgotPasswordWebview loadHTMLString:errorString baseURL:nil];
    activityIndicator.hidden = YES;
}


- (void)dealloc {
	[forgotPasswordWebview release];
	forgotPasswordWebview = nil;
	[activityIndicator release];
	activityIndicator = nil;
    [super dealloc];
}


@end
