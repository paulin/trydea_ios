//
//  CommentDetailViewController.m
//  tryDea
//
//  Created by Xenia Hertzenberg on 4/5/12.
//  Copyright (c) 2012 Feline Infinity. All rights reserved.
//

#import "CommentDetailViewController.h"

@implementation CommentDetailViewController
@synthesize commentText, commentAuthor, commentType, authorLabel, typeLabel, commentTextView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
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
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    self.authorLabel.text = self.commentAuthor;
    self.typeLabel.text = self.commentType;
    self.commentTextView.text = self.commentText;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.authorLabel = nil;
    self.commentTextView = nil;
    self.typeLabel = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)dealloc
{
    [commentType release];
    [commentText release];
    [commentAuthor release];
    [authorLabel release];
    [typeLabel release];
    [commentTextView release];
}

@end
