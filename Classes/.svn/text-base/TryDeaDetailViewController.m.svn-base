//
//  TryDeaDetailViewController1.m
//  tryDea
//
//  Created by Xenia Hertzenberg on 5/3/11.
//  Copyright 2011 Xenia H. All rights reserved.
//

#import "TryDeaDetailViewController.h"


@implementation TryDeaDetailViewController
@synthesize titleTextField, detailsTextView, myNewTryDeaTitle, controllerTitle, myNewTryDeaDetails, tryDea, currentAction, editing, canceled;

- (id)init
{	
	if (self=[super initWithNibName:@"TryDeaDetailViewController" bundle:[NSBundle mainBundle]]) {
        self.canceled = NO;
    }
	
	return self;
	
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	return [self init];
}


- (void)viewDidLoad {
    [super viewDidLoad];
	
	// navigation buttons
	UIBarButtonItem *button;
	if (self.editing) {
		button = [[UIBarButtonItem alloc]initWithTitle:@"Update" style:UIBarButtonItemStyleDone target:self action:@selector(update:)]; 

	}else{
		button = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(create:)]; 
	}
	
	[[self navigationItem]setRightBarButtonItem:button];
	[button release];
	
	button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
	[[self navigationItem]setLeftBarButtonItem:button];
	[button release];
	
	if (self.controllerTitle) {
		[self setTitle:controllerTitle];
	}
	
	detailsTextView.delegate = self;
	
	if (self.tryDea == nil) {
		self.titleTextField.placeholder = @"New TryDea Title";
	}else{
		self.titleTextField.text = tryDea.title;
		self.detailsTextView.text = tryDea.details;
	}
	
    UINavigationBar *bar = [self.navigationController navigationBar];	
	[bar setBarStyle:UIBarStyleBlack];
	[bar setTranslucent:NO];
	

}

#pragma mark IBActions
- (IBAction)cancel:(id)sender
{
	
	[self.tryDea release]; 
	self.canceled = YES;
	[[self navigationController]popViewControllerAnimated:YES];
	
}
- (IBAction)create:(id)sender
{
	self.myNewTryDeaTitle = self.titleTextField.text;
	self.myNewTryDeaDetails = self.detailsTextView.text;
	NSLog(@"Text: %@", self.detailsTextView.text);
	[[self navigationController]popViewControllerAnimated:YES];
}
- (IBAction)update:(id)sender
{
	self.tryDea.title = self.titleTextField.text;
	self.tryDea.details = self.detailsTextView.text;
	self.tryDea.updated_date = [NSDate date];
	self.tryDea.state = [NSNumber numberWithInt:state_local];
	[[self navigationController]popViewControllerAnimated:YES];
}

- (IBAction)hideKeyboard:(id)sender
{
	[sender resignFirstResponder];
}

#pragma mark UITextViewDelegate protocol methods
- (void)textViewDidBeginEditing:(UITextView *)textView
{
	NSLog(@"textViewDidBeginEditing");
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
	NSLog(@"DidEndEditing");
	[textView resignFirstResponder];
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
	NSLog(@"ShouldEndEditing");
	[textView resignFirstResponder];
	
	return YES;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
   self.titleTextField = nil;
   self.detailsTextView = nil;
   
}


- (void)dealloc {	
	if (tryDea) {
		[tryDea release];
	}    
	[titleTextField release];
	[controllerTitle release];
	[myNewTryDeaTitle release];
	[myNewTryDeaDetails release];
	[detailsTextView release];
	[super dealloc];
}



@end
