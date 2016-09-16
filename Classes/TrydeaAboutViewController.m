//
//  TrydeaAboutViewController.m
//  tryDea
//
//  Created by Xenia Hertzenberg on 4/24/12.
//  Copyright (c) 2012 Feline Infinity. All rights reserved.
//

#import "TrydeaAboutViewController.h"
#import "TryDeaUtils.h"
#import "Constants.h"



@implementation TrydeaAboutViewController
@synthesize scrollView, contentView;

#pragma MFMailComposeViewControllerDelegate
-(IBAction)sendMessage:(id)sender
{
    
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        mailer.mailComposeDelegate = self;
        [mailer setSubject:@"Trydea feedback"];
        
        //TODO: put destination address into constants
        NSArray *toRecipients = [NSArray arrayWithObjects:FEEDBACK_EMAIL_ADDRESS, nil];
        [mailer setToRecipients:toRecipients];
        
        [self presentModalViewController:mailer animated:YES];
    }
    else
    {
        [TryDeaUtils showAlertWithTitle:@"Cannot send mail" andMessage:@"Your device does not have mail capabilities"];
        
    }
}


- (void)mailComposeController:(MFMailComposeViewController*)controller 
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError*)error 
{ 
    if(error) NSLog(@"ERROR - mailComposeController: %@", [error localizedDescription]);
    [self dismissModalViewControllerAnimated:YES];
    return;
}

-(id)init
{
	UITabBarItem *tbi = [self tabBarItem];
	[tbi setTitle:@"About"];
	[tbi setImage:[UIImage imageNamed:@"about_white.png"]];
	[self setTitle:@"About"];
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
    [scrollView addSubview:contentView]; 
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.contentView.frame.size.height); 
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

#pragma util
-(IBAction)urlButtonClicked:(id)sender{
    NSString *urlString;
    if ([sender tag] == PUGETWORKS_TAG) {
        urlString = PUGETWORKS_URL;
    }else{
        urlString = THINKTANK_URL;
    }
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    if (![[UIApplication sharedApplication] openURL:url])
    {
        NSLog(@"%@%@",@"Failed to open url:",[url description]);
    }

}

@end
