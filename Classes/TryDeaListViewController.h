//
//  TryDeaListViewController.h
//  tryDea
//
//  Created by Xenia Hertzenberg on 5/1/11.
//  Copyright 2011 Xenia H. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TryDeaDetailViewController.h"
#import "TryDeaHTTP.h"
#import "Constants.h"

@interface TryDeaListViewController : UITableViewController {
	
	NSMutableArray *tryDeaList;
	TryDeaDetailViewController *detailViewController;
	NSMutableData *receivedData;
	TryDeaHTTP *tryDeaHTTP;
	HttpAction currentAction;
    TryDea *tryDeaToBePublished;
	
    SortingOrder currentSortingOrder;
	
}
-(void)createNewTryDea:(id)sender;
-(void)loadTryDeasFromServer:(id)sender;
//-(void)loadTryDeaFromServer:(id)sender;
-(NSArray*)parseJSONTryDeas:(NSString*)tryDeasJSONString;
-(bool)tryDeaListContainsRemoteTryDea:(TryDea *)newTryDea;
-(void)executeRequestToUrl:(NSString *)serverUrl withHeaders:(NSDictionary*)headers  andCurrentAction:(HttpAction)action andData:(NSData*)data usingMethod:(httpMethod)method;
-(UIButton *) createSortingButtonWithTitle:(NSString *)title andFrame:(CGRect)rect andTag:(int)tag;
- (IBAction)accessoryControlTapped:(UIControl*)control withEvent:(UIEvent*)event;
- (NSIndexPath*)indexPathForControl:(UIControl*)control withEvent:(UIEvent*)event;
- (void)sortTrydeasWithOrder:(SortingOrder)so;
-(IBAction)sortButtonClicked:(id)sender;
-(void)changeControllerTitleOnLogOff;

@property (nonatomic, retain) NSMutableData* receivedData;
@property (nonatomic, retain) TryDea* tryDeaToBePublished;
@property (nonatomic, retain) TryDeaHTTP* tryDeaHTTP;
@property (nonatomic, assign) HttpAction currentAction;
@property (nonatomic, assign) SortingOrder currentSortingOrder;

@end
