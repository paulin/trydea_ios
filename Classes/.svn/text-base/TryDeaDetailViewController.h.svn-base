//
//  TryDeaDetailViewController1.h
//  tryDea
//
//  Created by Xenia Hertzenberg on 5/3/11.
//  Copyright 2011 Xenia H. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TryDea.h"
#import "Constants.h"


@interface TryDeaDetailViewController : UIViewController <UITextViewDelegate> {
	IBOutlet UITextField *titleTextField;
	IBOutlet UITextView  *detailsTextView;
	TryDea *tryDea;
	NSString *controllerTitle;
	bool editing;
	bool canceled;
	NSString *myNewTryDeaTitle;
	NSString *myNewTryDeaDetails;
	HttpAction currentAction;
}

@property (nonatomic, retain) IBOutlet UITextField *titleTextField;
@property (nonatomic, retain) IBOutlet UITextView *detailsTextView;
@property (nonatomic, retain) NSString *myNewTryDeaTitle;
@property (nonatomic, retain) NSString *myNewTryDeaDetails;
@property (nonatomic, retain) NSString *controllerTitle;
@property (nonatomic, retain) TryDea *tryDea;
@property (assign) bool editing;
@property (assign) bool canceled;
@property (assign) HttpAction currentAction;


- (IBAction)cancel:(id)sender;
- (IBAction)create:(id)sender;
- (IBAction)update:(id)sender;
- (IBAction)hideKeyboard:(id)sender;

@end
