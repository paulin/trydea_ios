//
//  TryDeaExtensiveDetailViewController.h
//  tryDea
//
//  Created by Xenia Hertzenberg on 8/17/11.
//  Copyright 2011 University of Washington. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TryDea.h"
#import "TryDeaHTTP.h"
#import "TryDeaUtils.h"


@interface TryDeaExtensiveDetailViewController : UITableViewController<UITextViewDelegate, UIAlertViewDelegate> {
    TryDea *tryDea;
    NSMutableData* receivedData;
    //IBOutlet UIActivityIndicatorView *activityIndicator;
	TryDeaHTTP *tryDeaHttp;
	int fightCount;
	int score;
	NSArray *teamMembers;
	NSArray *comments;
	HttpAction currentAction;
    UITextView *commentsTextView;
    int selectedCommentType;
    NSString *feedbackText;
	
	
}
-(void) parseJSONTryDea:(NSString *)jsonTryDea;
-(NSString *)getSectionTitle:(int)section;
//- (NSIndexPath*)indexPathForControl:(UIControl*)control withEvent:(UIEvent*)event;
-(void)submitNewComment;
-(void)leaveTeam;
-(void)commentTypeChanged:(id)sender;
-(void)clearFeedbackTextView;

@property (nonatomic, retain) TryDea* tryDea;
@property (nonatomic, retain) NSMutableData* receivedData;
//@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, retain) TryDeaHTTP *tryDeaHttp;

@property (nonatomic, assign) HttpAction currentAction;
@property (nonatomic, assign) int fightCount;
@property (nonatomic, assign) int score;
@property (nonatomic, retain) NSArray *teamMembers;
@property (nonatomic, retain) NSArray *comments;
@property (nonatomic, retain) UITextView *commentsTextView;
@property (nonatomic, retain) NSString *feedbackText;
@property (nonatomic, assign) int selectedCommentType;


@end
