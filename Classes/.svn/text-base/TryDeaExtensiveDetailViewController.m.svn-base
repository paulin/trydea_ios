//
//  TryDeaExtensiveDetailViewController.m
//  tryDea
//
//  Created by Xenia Hertzenberg on 8/17/11.
//  Copyright 2011 University of Washington. All rights reserved.
//

#import "TryDeaExtensiveDetailViewController.h"
#import "TryDeaDetailViewController.h"
#import "CommentDetailViewController.h"
#import "AppController.h"
#import "Constants.h"
#import "TrydeaDetailCell.h"
#import "NewCommentCell.h"
#import "CommentCell.h"
#import "TeamMemberCell.h"
#import "TryDeaUtils.h"
#import "JSON.h"

#define SECTION_HEADER_HIGHT 32
#define SECTION_HEIGHT 44
#define SECTION_TRYDEA_HEIGHT 254
#define SECTION_COMMENT_HEIGHT 42
#define SECTION_TEAM_HEIGHT 42
#define SECTION_FEEDBACK_HEIGHT 170
#define TRYDEA_TITLE_TAG 1
#define TRYDEA_DESCRIPTION_TAG 2
#define SUBMIT_FEEDBACK_TAG 7
#define FEEDBACK_TEXTVIEW_TAG  8
#define COMMENT_TYPE_CONTROL_TAG 9
#define LEAVE_BUTTON_TAG 8
@interface TryDeaExtensiveDetailViewController (PrivateMethods)
- (void) startAnimation;
- (void) stopAnimation;
@end

@implementation TryDeaExtensiveDetailViewController

@synthesize tryDea, currentAction, receivedData, tryDeaHttp, fightCount, score, teamMembers, comments, commentsTextView, feedbackText, selectedCommentType;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
		self.tableView.separatorColor = [UIColor clearColor];
        self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    }
    
      
    return self;
}

- (void)sendRequestToRetrieveTrydea {
    if (!self.tryDeaHttp) {
        self.tryDeaHttp = [[TryDeaHTTP alloc] init];
        self.tryDeaHttp.delegate = self;
    }
    
    self.currentAction = actionGetTryDea;
    if (self.receivedData) {
        [receivedData release];
    }
    self.receivedData = [[NSMutableData alloc]init];
    NSString *serverUrl = [NSString stringWithFormat:@"%@/%@/%@?ideaid=%i", [TryDeaUtils defaultValueForKey:tryDeaServerUrlVar], authorizedController, getIdea, [tryDea.server_id intValue]];
    NSLog(@"contacting server %@", serverUrl);
    
    //TODO:put into TryDeaUtils
    NSString *aUsername = [TryDeaUtils defaultValueForKey:@"username"];
    NSString *aPassword = [TryDeaUtils defaultValueForKey:@"password"];
    NSString *authHeader = [TryDeaUtils getEncodedStringForUsername:aUsername password:aPassword];
    
    NSDictionary* headers = [[NSDictionary alloc] initWithObjectsAndKeys:
                             authHeader ,@"Authorization",
                             @"application/json", @"Accept",
                             @"application/json", @"Content-type",
                             nil];
    //////	
    NSString *label = [NSString stringWithFormat:@"Loading idea '%@'", self.tryDea.title];
    AppController *appController = [AppController sharedAppController];
    [appController startAnimationWithLabel:label];
   
    [self.tryDeaHttp executeRequesttoUrl:serverUrl withHeaders:headers andData:nil usingMethod:httpMethodGet];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
	
    [super viewWillAppear:animated];
	if (currentAction != actionShowComment) {
		[self sendRequestToRetrieveTrydea];	
	}
	
}

- (void)dealloc
{
    // TODO: dealloc tryDea, receivedData
    [tryDea release];
    [tryDeaHttp release];
    [receivedData release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - private methods
- (void) startAnimation
{
	AppController *appController = [AppController sharedAppController];
	[appController startAnimation];
}


- (void) stopAnimation
{
	AppController *appController = [AppController sharedAppController];
	[appController stopAnimation];
}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad]; 
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] init];
    barButton.title = @"Back"; 
    self.navigationItem.backBarButtonItem = barButton;
    [barButton release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

/*
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
*/

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	NSLog(@"section:%i title: %@",section,[self getSectionTitle:section]);
	return [self getSectionTitle:section];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == titleSection){
        return 1;
  //  }else if(section == descriptionSection){
  //      return 1; //TODO
    }else if(section == leaveFeedbackSection){
        return 1;
    }else if(section == teamSection){
        if (self.teamMembers) {
			return [teamMembers count];
		}else {
			return 0;
		}

    }else{
        if (self.comments) {
			NSLog(@"comments count: %i", [comments count]);
			return [comments count];
		}else {
			return 0;
		}

    }
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if ([self tableView:tableView titleForHeaderInSection:section] != nil) {
        if (section == teamSection) {
            return SECTION_HEADER_HIGHT;
        }
        return SECTION_HEADER_HIGHT;
    }
    else {
        // If no section header title, no section header needed
        return 0;
    }
}


 - (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section { 
	
	 UIView* sectionHeaderView = [[[UIView alloc]initWithFrame:CGRectMake(0.0, 0.0, 320.0, SECTION_HEADER_HIGHT)]autorelease];
     sectionHeaderView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
   
	 UILabel * label = [[[UILabel alloc] initWithFrame:CGRectMake(10, 0.0, 260.0, SECTION_HEADER_HIGHT)] autorelease];
	 label.backgroundColor = [UIColor clearColor];
	 label.opaque = NO;
	 label.textColor = UIColorFromRGB(0xEFA44F);
	 label.font = [UIFont boldSystemFontOfSize:21];
	 label.textAlignment = UITextAlignmentLeft;
	 label.text = [self getSectionTitle:section];
	 [sectionHeaderView addSubview:label];
     
     CGSize textSize;
    #if defined(TARGET_IPHONE_SIMULATOR) || defined(TARGET_OS_IPHONE)
        textSize = [label.text sizeWithFont:label.font];
    #else
        textSize = NSSizeToCGSize([label.text sizeWithAttributes:[NSDictionary dictionaryWithObject:label.font forKey: NSFontAttributeName]]);
    #endif

     float stripeWidth = 320.0 - textSize.width - 32.0;
     float stripeX = textSize.width+22.0;
     UIView* sectionStripe1View = [[[UIView alloc]initWithFrame:CGRectMake(stripeX, 13.0, stripeWidth, 4.0)]autorelease];
     sectionStripe1View.backgroundColor = UIColorFromRGB(0xEFA44F);
     [sectionHeaderView addSubview:sectionStripe1View];
     
     UIView* sectionStripe2View = [[[UIView alloc]initWithFrame:CGRectMake(stripeX, 19.0, stripeWidth, 4.0)]autorelease];
     sectionStripe2View.backgroundColor = UIColorFromRGB(0xEFA44F);
     [sectionHeaderView addSubview:sectionStripe2View];
     
	 if (section == teamSection )
	 {
         /*
		 // add button to right corner of section
		 UIButton* button = [[UIButton buttonWithType:UIButtonTypeCustom]retain]; 
		 button.frame = CGRectMake(0,0,104, 38);				   
		 button.center = CGPointMake( 250.0, 17.0);
		 
        NSString *buttonTitle = @"Leave Team";
        [button setBackgroundImage:[UIImage imageNamed:@"i-want-out.png"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(leaveTeam) forControlEvents:UIControlEventTouchDown];

        [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [button setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 40.0, 0.0, 0.0)];
        button.titleLabel.font = [UIFont boldSystemFontOfSize:12];
         button.titleLabel.textColor = [UIColor lightTextColor];
        [button setTitleColor:UIColorFromRGB(0x777A7A) forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitle:buttonTitle forState:UIControlStateNormal];
       // [button setTitle:@"" forState:UIControlStateNormal];
         button.titleLabel.font = [UIFont systemFontOfSize:12];

        [buttonTitle release];
        button.tag = section;
        [sectionHeaderView addSubview:button];
        [button release];
          */
	 }
     return sectionHeaderView;
 }


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == titleSection) {
        return SECTION_TRYDEA_HEIGHT;
    }else if(indexPath.section == leaveFeedbackSection)
    {
        return SECTION_FEEDBACK_HEIGHT;
    }else if(indexPath.section == commentsSection){
    
        return SECTION_COMMENT_HEIGHT;
    }else if(indexPath.section == teamSection)
    {
        return SECTION_TEAM_HEIGHT;
    }else
    {
        return 44;
    }
}

#pragma UITextViewDelegate methods
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    textView.text = @"";
    textView.textColor = [UIColor blackColor];
    UITableViewCell *cell = (UITableViewCell*) [[textView superview]superview];
    [self.tableView scrollToRowAtIndexPath:[self.tableView indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionTop+100 animated:YES];

   return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    [textView resignFirstResponder];
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.text == nil || textView.text.length < 2) {
        [TryDeaUtils showAlertWithTitle:@"Cannot submit" andMessage:@"Please enter some text into the comment field, and then submit"];
    }
    self.feedbackText = textView.text;
    [textView resignFirstResponder];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    if ([self.commentsTextView isFirstResponder] && [touch view] != self.commentsTextView)
    {
        [self.commentsTextView resignFirstResponder];
    }
}

- (void)scrollRectToVisible:(CGRect)rect animated:(BOOL)animated
{
    // do nothing. This fixes the cursor jumping above the field defect.
}


-(void)commentTypeChanged:(id)sender
{
    UISegmentedControl *control = (UISegmentedControl *)sender;
    NSLog(@"Segmented control value changed: %i", control.selectedSegmentIndex);
    self.selectedCommentType = control.selectedSegmentIndex;
}

/*
-(void)joinTeam
{
    NSLog(@"I am joining team for this idea!");
    
    // TODO: check if logged in
    // TODO: put into TryDeaUtils
    NSString *aUsername = [TryDeaUtils defaultValueForKey:@"username"];
    NSString *aPassword = [TryDeaUtils defaultValueForKey:@"password"];
    NSString *authHeader = [TryDeaUtils getEncodedStringForUsername:aUsername password:aPassword];
    
    NSDictionary* headers = [[NSDictionary alloc] initWithObjectsAndKeys:
                             authHeader ,@"Authorization",
                             @"application/json", @"Accept",
                             @"application/json", @"Content-type",
                             nil];
    
    NSString *ideaid = [NSString stringWithFormat:@"%i", [self.tryDea.server_id intValue]];
    
    NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys:
                            ideaid,@"ideaid",
                            nil];
    
    SBJsonWriter *writer = [SBJsonWriter new];	
    NSString* paramString = [writer stringWithObject:params];
    NSData *data = [paramString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *serverUrl = [NSString stringWithFormat:@"%@/%@/%@", [TryDeaUtils defaultValueForKey:tryDeaServerUrlVar], authorizedController, joinTeam];

    self.receivedData = [[NSMutableData alloc]init];
    if (self. tryDeaHttp == nil) {
        self.tryDeaHttp = [[TryDeaHTTP alloc]init];
        self.tryDeaHttp.delegate=self;
    }
    self.currentAction = actionJoinTeam;
    [self.tryDeaHttp executeRequesttoUrl:serverUrl withHeaders:headers andData:data usingMethod:httpMethodPost];
    AppController* appController = [AppController sharedAppController];
    [appController startAnimationWithLabel:@"Sending request to join the team"];
 
}
 */

-(void)leaveTeam
{
    // TODO: check if logged in
    // TODO: put into TryDeaUtils
    NSString *aUsername = [TryDeaUtils defaultValueForKey:@"username"];
    NSString *aPassword = [TryDeaUtils defaultValueForKey:@"password"];
    NSString *authHeader = [TryDeaUtils getEncodedStringForUsername:aUsername password:aPassword];
    
    NSDictionary* headers = [[NSDictionary alloc] initWithObjectsAndKeys:
                             authHeader ,@"Authorization",
                             @"application/json", @"Accept",
                             @"application/json", @"Content-type",
                             nil];
    
    NSString *ideaid = [NSString stringWithFormat:@"%i", [self.tryDea.server_id intValue]];
    
    NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys:
                            ideaid,@"ideaid",
                            nil];
    
    SBJsonWriter *writer = [SBJsonWriter new];	
    NSString* paramString = [writer stringWithObject:params];
    NSData *data = [paramString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *serverUrl = [NSString stringWithFormat:@"%@/%@/%@", [TryDeaUtils defaultValueForKey:tryDeaServerUrlVar], authorizedController, leaveTeam];
    
    self.receivedData = [[NSMutableData alloc]init];
    if (self. tryDeaHttp == nil) {
        self.tryDeaHttp = [[TryDeaHTTP alloc]init];
        self.tryDeaHttp.delegate=self;
    }
    self.currentAction = actionLeaveTeam;
    [self.tryDeaHttp executeRequesttoUrl:serverUrl withHeaders:headers andData:data usingMethod:httpMethodPost];
    AppController* appController = [AppController sharedAppController];
    [appController startAnimationWithLabel:@"Sending request to leave the team"];
    [writer release];
     
}
-(void)submitNewComment
{
    [self.commentsTextView resignFirstResponder];
    NSLog(@"I shall be submitting new comment");
    
    // TODO: check if logged in
    // TODO: put into TryDeaUtils
    NSString *aUsername = [TryDeaUtils defaultValueForKey:@"username"];
    NSString *aPassword = [TryDeaUtils defaultValueForKey:@"password"];
    NSString *authHeader = [TryDeaUtils getEncodedStringForUsername:aUsername password:aPassword];
		
    NSDictionary* headers = [[NSDictionary alloc] initWithObjectsAndKeys:
								 authHeader ,@"Authorization",
								 @"application/json", @"Accept",
								 @"application/json", @"Content-type",
								 nil];
       
    NSString *ideaid = [NSString stringWithFormat:@"%i", [self.tryDea.server_id intValue]];
        
    NSString *commentType = nil;
    switch (selectedCommentType) 
    {
        case 0:
            commentType = @"comment";
            break;
        case 1:
            commentType = @"feature";
            break;
        case 2:
            commentType = @"competitor";
            break;
        case 3:
            commentType = @"name";
            break;
        default:
            break;
            commentType = @"comment";
    }
        
    NSLog(@"Comment Type: %@ (selected segment %i)", commentType, self.selectedCommentType);
        
    NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys:
                                ideaid,@"ideaid",
                                self.feedbackText, @"comment",
                                commentType, @"type",
                                nil];
        
    SBJsonWriter *writer = [SBJsonWriter new];	
    NSString* paramString = [writer stringWithObject:params];
    NSData *data = [paramString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *serverUrl = [NSString stringWithFormat:@"%@/%@/%@", [TryDeaUtils defaultValueForKey:tryDeaServerUrlVar], authorizedController, submitComment];
    NSLog(@"comments paramsString: %@", paramString);
    NSLog(@"serverURL: %@", serverUrl);
        
    self.receivedData = [[NSMutableData alloc]init];
    if (self. tryDeaHttp == nil) {
        self.tryDeaHttp = [[TryDeaHTTP alloc]init];
        self.tryDeaHttp.delegate=self;
    }
    self.currentAction = actionSubmitComment;
    [self.tryDeaHttp executeRequesttoUrl:serverUrl withHeaders:headers andData:data usingMethod:httpMethodPost];
    AppController* appController = [AppController sharedAppController];
    [appController startAnimationWithLabel:@"Submitting comment"];
    [writer release];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell;
    
    if (indexPath.section == titleSection) {
        cell = (UITableViewCell *)[TrydeaDetailCell cellForTable:tableView withOwner:self];
        UITextField *titleField = (UITextField *)[cell viewWithTag:TRYDEA_TITLE_TAG];
        titleField.text = self.tryDea.title;
        UITextView *descField = (UITextView *)[cell viewWithTag:TRYDEA_DESCRIPTION_TAG];
        descField.text = self.tryDea.details;
    }else if(indexPath.section == leaveFeedbackSection){
        cell = (UITableViewCell *)[NewCommentCell cellForTable:tableView withOwner:self];
        UIButton *leaveCommentButton = (UIButton *)[cell viewWithTag:SUBMIT_FEEDBACK_TAG]; 
        [leaveCommentButton addTarget:self action:@selector(submitNewComment) forControlEvents:UIControlEventTouchDown];
        UITextView *commentTextView = (UITextView *)[cell viewWithTag:FEEDBACK_TEXTVIEW_TAG];
        self.commentsTextView = commentTextView;
        commentTextView.delegate = self;
        UISegmentedControl *commentTypeControl = (UISegmentedControl *)[cell viewWithTag:COMMENT_TYPE_CONTROL_TAG];
        [commentTypeControl addTarget:self action:@selector(commentTypeChanged:) forControlEvents:UIControlEventValueChanged];
    }else if(indexPath.section == teamSection){
        cell = (UITableViewCell *)[TeamMemberCell cellForTable:tableView withOwner:nil];
        if (teamMembers) {
			NSDictionary *tm = [teamMembers objectAtIndex:indexPath.row];
            NSString *usrnm = [TryDeaUtils defaultValueForKey:@"username"];
            if ([usrnm isEqualToString:[tm objectForKey:@"name"]]) {
                ((TeamMemberCell *)cell).leaveButton.hidden = NO;
                 ((TeamMemberCell *)cell).leaveLabel.hidden = NO;
                [((TeamMemberCell *)cell).leaveButton addTarget:self action:@selector(leaveTeam) forControlEvents:UIControlEventTouchUpInside];
                UIImage *buttonImage = [[UIImage imageNamed:@"i-want-out.png"]  
                                        resizableImageWithCapInsets:UIEdgeInsetsMake(0, 32, 0, 16)];
                [((TeamMemberCell *)cell).leaveButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
                
            }else
            {
                ((TeamMemberCell *)cell).leaveButton.hidden = YES;
                ((TeamMemberCell *)cell).leaveLabel.hidden = YES;
            }
			((TeamMemberCell *)cell).bottomLabel.text = [tm objectForKey:@"name"];
		}
    }else if(indexPath.section == commentsSection){
        cell = (UITableViewCell *)[CommentCell cellForTable:tableView withOwner:self];
        //cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"row2.png"]];
		if (comments) {
			NSDictionary *comm = [comments objectAtIndex:indexPath.row];
            CommentCell *commCell = (CommentCell *)cell;
            commCell.bottomLabel.text = [comm objectForKey:@"comment"];
            commCell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"row2_left.png"]];
            
			NSString *commentType = [comm objectForKey:@"type"];
			if ([commentType isEqualToString:@"comment"]) {
				((CommentCell *)cell).customImageView.image = [UIImage imageNamed:@"comment.png"];
                ((CommentCell *)cell).topLabel.text = @"Comment";
			}else if ([commentType isEqualToString:@"competitor"]) {
				//cell.imageView.image = [UIImage imageNamed:@"competitor.png"];
                ((CommentCell *)cell).customImageView.image = [UIImage imageNamed:@"competitor.png"];
                 ((CommentCell *)cell).topLabel.text = @"Competitor";
			}else if ([commentType isEqualToString:@"feature"]) {
				((CommentCell *)cell).customImageView.image = [UIImage imageNamed:@"feature.png"];
                 ((CommentCell *)cell).topLabel.text = @"Feature";
			}else if ([commentType isEqualToString:@"name"]) {
				((CommentCell *)cell).customImageView.image =[UIImage imageNamed:@"name.png"];
                 ((CommentCell *)cell).topLabel.text = @"Name";
			}else {
				
			}
		}
        
    }else{
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    return cell;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
     if (indexPath.section == titleSection 
       //  || indexPath.section == descriptionSection
         ) {
         NSIndexPath *selectedPath = [[self tableView] indexPathForSelectedRow];
         [[self tableView] deselectRowAtIndexPath:selectedPath animated:NO]; 
         /*
		 TryDeaDetailViewController *detailViewController = [[TryDeaDetailViewController alloc] initWithNibName:@"TryDeaDetailsViewController" bundle:nil];
		// detailViewController = [[TryDeaDetailViewController alloc] init];
		 detailViewController.tryDea = tryDea;
		 detailViewController.controllerTitle = @"TryDea Details";
		 self.currentAction = actionShowComment;
 		 detailViewController.editing = NO;
		 [self.navigationController pushViewController:detailViewController animated:YES]; 
		 [detailViewController release];
          */
	 }else if (indexPath.section == commentsSection) {
		 CommentDetailViewController *commentDetailViewController = [[CommentDetailViewController alloc] init];
		 commentDetailViewController.commentAuthor = [[self.comments objectAtIndex:indexPath.row] objectForKey:@"author"];
         commentDetailViewController.commentText = [[self.comments objectAtIndex:indexPath.row] objectForKey:@"comment"];
         commentDetailViewController.commentType = [[self.comments objectAtIndex:indexPath.row] objectForKey:@"type"];                                                   
		 self.currentAction = actionShowComment;
		 [self.navigationController pushViewController:commentDetailViewController animated:YES]; 
		 [commentDetailViewController release];
	 }
     
}

#pragma mark NSURLConnection delegate methods
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	NSLog(@"Received response: %@", response);	
	[receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	NSLog(@"Received %d bytes of data", [data length]); 
	
	[receivedData appendData:data];
	NSLog(@"Received data is now %d bytes", [receivedData length]); 
	
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	NSLog(@"Error receiving response: %@", [error localizedDescription]);
	if (self.tryDeaHttp)
	{
		[tryDeaHttp release];
	}
	[TryDeaUtils showAlertWithTitle:@"Server Error" andMessage:@"Error received from server, please try connecting later"];
	AppController *appController = [AppController sharedAppController];
	[appController stopAnimation];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	NSLog(@"Succeeded! Received %d bytes of data", [receivedData length]); 
	
	NSString *dataStr=[[NSString alloc] initWithData:receivedData encoding:NSASCIIStringEncoding];
	NSLog(@"Succeeded! Received %@ bytes of data, ready to load it into my extensive view", dataStr); 
	
	
	if (currentAction == actionGetTryDea) {
        NSLog(@"TRYDEA: %@", dataStr);
		[self parseJSONTryDea:dataStr];
        [[self tableView] reloadData];
        if (self.tryDeaHttp)
        {
         //   [tryDeaHttp release];
        }
        [self setTitle:self.tryDea.title];
	} 
   
	AppController *appController = [AppController sharedAppController];
	[appController stopAnimation];
	
	    
    if(currentAction == actionSubmitComment)
    {
        NSLog(@"Comment submitted: %@", dataStr);
        // reload trydea
        [self sendRequestToRetrieveTrydea];
        [self clearFeedbackTextView];
        self.feedbackText = @"";
    }
    
    if(currentAction == actionLeaveTeam) 
    {
        NSString *message = [NSString stringWithFormat:@"User %@ left team of the idea \"%@\"", [TryDeaUtils defaultValueForKey:@"username"], self.tryDea.title];
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Thank you"
                              message: message
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
        [alert release];
        
    }
    [dataStr release];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	[self.navigationController popViewControllerAnimated:YES];
}


#pragma mark Utility

-(void)clearFeedbackTextView
{
    self.commentsTextView.text = @"Please enter your feedback here";
    self.commentsTextView.textColor = [UIColor lightGrayColor];
}
-(NSString *)getSectionTitle:(int)section
{
	if(section == titleSection){
        return nil;
  //  }else if(section == descriptionSection){
  //      return @"Description";
    }else if(section == teamSection){
        return @"Team";
    }else if (section == commentsSection){
        return @"Comments";
    }else if (section == leaveFeedbackSection){
        return @"Leave Feedback";
    }else {
		return @"";
	}

}
-(void)parseJSONTryDea:(NSString *)jsonTryDea
{
	SBJsonParser *parser = [[SBJsonParser alloc]init];
	NSError *error = nil;
	@try{ 
		NSDictionary* tryDeaJsonDict =[parser objectWithString:jsonTryDea error:&error];
		NSString *responseStatus =[tryDeaJsonDict objectForKey:@"status"];
		if ([responseStatus isEqualToString:@"success"]) {
			NSDictionary *tryDeaCompleteInfo = [tryDeaJsonDict objectForKey:@"idea"];
			self.score = [[tryDeaCompleteInfo objectForKey:@"score"] intValue];
			self.fightCount = [[tryDeaCompleteInfo objectForKey:@"fight_count"] intValue];
			self.teamMembers = [tryDeaCompleteInfo objectForKey:@"team_members"];
			self.comments = [tryDeaCompleteInfo objectForKey:@"comments"];
		}else{
			// TODO: extract
			NSString *message = [NSString stringWithFormat:@"Could not load published idea '%@'", tryDea.title];
			[TryDeaUtils showAlertWithTitle:@"Error" andMessage:message];
		}

	}@catch (NSException *exception) {
		NSString *message = [NSString stringWithFormat:@"Could not load published idea '%@'", tryDea.title];
		[TryDeaUtils showAlertWithTitle:@"Error" andMessage:message];
	}@finally {
		[parser release];
	}
}



@end
