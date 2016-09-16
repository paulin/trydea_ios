//
//  TrydeaAboutViewController.h
//  tryDea
//
//  Created by Xenia Hertzenberg on 4/24/12.
//  Copyright (c) 2012 Feline Infinity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface TrydeaAboutViewController : UIViewController<MFMailComposeViewControllerDelegate>
{
    UIScrollView *scrollView;
    UIView *contentView;
}

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UIView *contentView;

-(IBAction)sendMessage:(id)sender;
-(IBAction)urlButtonClicked:(id)sender;

@end
