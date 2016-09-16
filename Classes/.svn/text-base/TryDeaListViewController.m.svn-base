//
//  TryDeaListViewController.m
//  tryDea
//
//  Created by Xenia Hertzenberg on 5/1/11.
//  Copyright 2011 Xenia H. All rights reserved.
//

#import "TryDeaListViewController.h"
#import "TryDeaExtensiveDetailViewController.h"
#import "AppController.h"
#import "TryDea.h"
#import "TableCell.h"
#import "TryDeaListCell.h"
#import "TryDeaUtils.h"
#import "JSON.h"



#define TRYDEA_TITLE_TAG 7
#define TRYDEA_DETAIL_TAG 8
#define BUTTON_TAG 5
#define TRYDEA_TEAM_TAG 0
#define NUM_TEAM_TAG 1
#define TRYDEA_COMMENTS_TAG 2
#define NUM_COMMENTS_TAG 3
#define RIGHT_BACKGROUND_IMAGE_TAG 4



@interface TryDeaListViewController(Private) 

	//-(BOOL)isEmptyTryDea:(TryDea *)tryDea;

@end

@implementation TryDeaListViewController

@synthesize receivedData, tryDeaHTTP, currentAction, currentSortingOrder, tryDeaToBePublished;
#pragma mark -
#pragma mark View lifecycle

- (id)init
{
	//[super initWithStyle:UITableViewStylePlain];
	if (self =  [super initWithStyle:UITableViewStylePlain]) {
        AppController *appController = [AppController sharedAppController];
        NSArray *list = [appController allInstancesOf:@"TryDea" orderedBy:@"created_date"];
        
        tryDeaList = [list mutableCopy];	
        
        UITabBarItem *tbi = [self  tabBarItem];
        [tbi setTitle:@"List"];
        [tbi setImage:[UIImage imageNamed:@"ideas_white.png"]];
        [self.navigationItem setHidesBackButton:TRUE];
        
        UIBarButtonItem *barButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                  target:self
                                                                                  action:@selector(createNewTryDea:)];
        
        [[self navigationItem] setRightBarButtonItem:barButton];
        [barButton release];
        
        barButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                                 target:self
                                                                 action:@selector(loadTryDeasFromServer:)];
        
        [[self navigationItem] setLeftBarButtonItem:barButton];
        [barButton release];
        
        self.currentSortingOrder = sortingOrderAlphaAsc;
    }
	    
	return self;
}

- (id) initWithStyle:(UITableViewStyle)style
{
	return [self init];
}



- (void)viewDidLoad {
    [super viewDidLoad];
	self.tableView.separatorColor = [UIColor clearColor];
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    
    UIButton *button1= [self createSortingButtonWithTitle:@"Sort by Date" andFrame:CGRectMake(30.0, 4.0, 110, 30) andTag:SORT_BY_DATE_BUTTON_TAG];
    
    UIButton *button2= [self createSortingButtonWithTitle:@"Sort by Title" andFrame:CGRectMake(177, 4.0, 110, 30) andTag:SORT_BY_TITLE_BUTTON_TAG];
    
    [headerView addSubview:button1];
    [headerView addSubview:button2];
    
    self.tableView.tableHeaderView = headerView;
    [headerView release];
    
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"background.png"]];
    self.tableView.backgroundColor = background;
    [background release];

    UINavigationBar *bar = [self.navigationController navigationBar];	
	
	[bar setBarStyle:UIBarStyleBlack];
	[bar setTranslucent:NO];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeControllerTitleOnLogOff) name:LOGOFF_NOTIFICATION object:nil];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tableView.rowHeight = 61.f;
	
    NSString *usrnm = [TryDeaUtils defaultValueForKey:@"username"];
    NSString *navBarTitle = @"Your tryDeas";
    if (usrnm && usrnm.length > 1) {
        navBarTitle = [NSString stringWithFormat:@"%@'s tryDeas", usrnm];
    }
	[self setTitle:navBarTitle];
    
	if(detailViewController && !detailViewController.canceled)
	{
		if(![detailViewController.myNewTryDeaTitle isEqualToString:@""])
		{			
			// new tryDea has been created
			if(!detailViewController.editing)
			{
				AppController *controller = [AppController sharedAppController];
				NSManagedObjectContext * moc = [controller managedObjectContext];
				
				TryDea *trydea = (TryDea *)[NSEntityDescription insertNewObjectForEntityForName:@"TryDea" inManagedObjectContext:moc];
				trydea.title = detailViewController.myNewTryDeaTitle;
				trydea.details = detailViewController.myNewTryDeaDetails;
				NSLog(@"Details (trydea): %@ ; details(from textArea) %@", trydea.details, detailViewController.myNewTryDeaDetails );
				trydea.created_date = [NSDate date];
				trydea.updated_date = [NSDate date];
				trydea.state = [NSNumber numberWithInt:state_local];
				[tryDeaList addObject:trydea];
                
			}
			
            [self sortTrydeasWithOrder:self.currentSortingOrder];
            [detailViewController release];
            detailViewController=nil;
	    }
	
		//clear the selection
		NSIndexPath *selectedPath = [[self tableView] indexPathForSelectedRow];
		if(selectedPath)
		{
			[[self tableView] deselectRowAtIndexPath:selectedPath animated:NO]; 
		}
	}else {
        if ([[TryDeaUtils defaultValueForKey:@"status"] isEqualToString:LOGGEDIN]) {
            [self loadTryDeasFromServer:nil];
        }else
        {
            NSMutableArray *remoteTryDeas = [[NSMutableArray alloc]init];
            for (TryDea* t in tryDeaList) {
                if ([t.state intValue] == state_remote) {
                    [remoteTryDeas addObject:t];
                }
            }
            [tryDeaList removeObjectsInArray:remoteTryDeas];
            [remoteTryDeas release];
            [[self tableView] reloadData];
        }
		
	}

}

#pragma mark Utility methods
-(UIButton *) createSortingButtonWithTitle:(NSString *)title andFrame:(CGRect)rect andTag:(int)tag
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = tag;
    button.backgroundColor = [UIColor clearColor];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:11];
    UIImage *buttonImage = [[UIImage imageNamed:@"button.png"]  
                        resizableImageWithCapInsets:UIEdgeInsetsMake(0, 32, 0, 16)];

    button.frame = rect;
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];

    [button addTarget:self action:@selector(sortButtonClicked:) forControlEvents:UIControlEventTouchDown];
    [button setTitle:title forState:UIControlStateNormal];
    
    CGRect frameForL1 = (tag == SORT_BY_DATE_BUTTON_TAG)? CGRectMake(5.0, 0.0, 45, 30) : CGRectMake(17.0, 0.0, 45, 30);
    CGRect frameForL2 = (tag == SORT_BY_DATE_BUTTON_TAG)? CGRectMake(45.0, 0.0, 75, 30) : CGRectMake(58.0, 0.0, 75, 30);
    
    UILabel *l1 = [[UILabel alloc]initWithFrame:frameForL1];
    l1.backgroundColor  =[UIColor clearColor];
    l1.tag = 1;
    l1.textColor = [UIColor whiteColor];
    l1.font = [UIFont boldSystemFontOfSize:11];
    UILabel *l2 = [[UILabel alloc]initWithFrame:frameForL2];
    l2.textColor = GREEN_COLOR;
    l2.tag = 2;
    l2.backgroundColor  =[UIColor clearColor];
    l2.font = [UIFont boldSystemFontOfSize:11];
    [button addSubview:l1];
    [button addSubview:l2];
    return button;
}

-(void)createNewTryDea:(id)sender
{
	detailViewController = [[TryDeaDetailViewController alloc] init];
	detailViewController.titleTextField.placeholder = @"New TryDea title";
	detailViewController.controllerTitle = @"Create new Trydea";
	detailViewController.detailsTextView.text = @"";
	detailViewController.editing = NO;
    [[self navigationController] pushViewController:detailViewController animated:YES];
}

- (NSDictionary *) getAuthorizedHeaders {
    NSString *aUsername = [TryDeaUtils defaultValueForKey:@"username"];
	NSString *aPassword = [TryDeaUtils defaultValueForKey:@"password"];
    NSString *authHeader = [TryDeaUtils getEncodedStringForUsername:aUsername password:aPassword];

	NSDictionary* headers = [[NSDictionary alloc] initWithObjectsAndKeys:
							 authHeader ,@"Authorization",
							 @"application/json", @"Accept",
							 @"application/json", @"Content-type",
							 nil];
  return headers;
}
-(void)loadTryDeasFromServer:(id)sender
{
	//TODO: refactor checking for logged in into a method
	NSLog(@"I bet the server has some exciting idea!");
	if (![[TryDeaUtils defaultValueForKey:@"status"] isEqualToString:LOGGEDIN]) {
        [TryDeaUtils showAlertWithTitle:@"User not logged in" andMessage:ERROR_MESSAGE_LOGIN_TO_VIEW_PUBLISHED_TRYDEAS];
        return;
	}
	
	AppController *appController = [AppController sharedAppController];
	[appController startAnimation];
	
	NSString *serverUrl = [NSString stringWithFormat:@"%@/%@/%@", [TryDeaUtils defaultValueForKey:tryDeaServerUrlVar], authorizedController, getIdeas];
    NSDictionary *headers;
    headers = [self getAuthorizedHeaders];
    [self.navigationItem.leftBarButtonItem setEnabled:NO];
    [self executeRequestToUrl:serverUrl withHeaders:headers andCurrentAction:actionLoad andData:nil usingMethod:httpMethodGet];
    
}
/*
-(void)loadTryDeaFromServer:(id)sender{
    // TODO: easy TryDeaUtil method ...loggedIN
    if (![[TryDeaUtils defaultValueForKey:@"status"] isEqualToString:LOGGEDIN]) {
        [TryDeaUtils showAlertWithTitle:@"User not logged in" andMessage:ERROR_MESSAGE_LOGIN_TO_VIEW_PUBLISHED_TRYDEAS];
        return;
	}
	
	NSString *serverUrl = [NSString stringWithFormat:@"%@/%@/%@?ideaid=1", [TryDeaUtils defaultValueForKey:tryDeaServerUrlVar], authorizedController, getIdea];
    NSDictionary *headers;
    headers = [self getAuthorizedHeaders];
    [self.navigationItem.leftBarButtonItem setEnabled:NO];
    [self executeRequestToUrl:serverUrl withHeaders:headers andCurrentAction:actionGetTryDea andData:nil usingMethod:httpMethodGet];
}
*/
-(void)changeControllerTitleOnLogOff
{
    UITabBarItem *tbi = [self  tabBarItem];
    [tbi setTitle:@"Your Trydeas"];
}
-(void)executeRequestToUrl:(NSString *)serverUrl withHeaders:(NSDictionary*)headers andCurrentAction:(HttpAction)action andData:(NSData*)data usingMethod:(httpMethod)method
{
    self.currentAction = action;
	// if there was anything in receivedData before - ciao!
	if (self.receivedData)
	{
		[receivedData release];
		receivedData = nil;
	}
	self.receivedData = [[NSMutableData alloc] init];
	
    tryDeaHTTP = [[TryDeaHTTP alloc]init];
	[tryDeaHTTP setDelegate:self];
	[tryDeaHTTP executeRequesttoUrl:serverUrl withHeaders:headers andData:data usingMethod:method];
    
}
- (bool)tryDeaListContainsRemoteTryDea:(TryDea *)newTryDea
{
	for (TryDea *tryDea in tryDeaList) {
		//NSLog(@"Comparing tryDea: %@ to newTryDea: %@", tryDea.title, newTryDea.title);
		if ([tryDea.server_id intValue] == [newTryDea.server_id intValue]) {
			//NSlog(@"But it's the same!");
			return YES;
		}
	}
	return NO;
}	

-(NSArray*)parseJSONTryDeas:(NSString*)tryDeasJSONString
{
	//TODO: NSDictionary blah = parseResponse:response forRequest:@"list_of_ideas"
	SBJsonParser *parser = [[SBJsonParser alloc]init];
	NSError *error = nil;
	NSArray *tryDeasJSONArray = nil;
	NSMutableArray *trydeas = [[NSMutableArray alloc]init];
	
	@try{ 
		NSDictionary *tryDeasStatusi =[parser objectWithString:tryDeasJSONString error:&error];
        NSLog(@"This is the string we got from the server: %@", tryDeasJSONString);
		NSString *responseStatus =[tryDeasStatusi objectForKey:@"status"];
		if ([responseStatus isEqualToString:@"success"]) {
			
			tryDeasJSONArray = [tryDeasStatusi objectForKey:@"statuses"];
			/*
			 *  NB: at the moment (08/2011), we are just pulling objects from remote server - the user will not be able
			 *  to manupulate them, or save them locally. Hence, we do not save them into Data Store. This is accomplished my 
			 *  passing 'nil' for the ManagedContext. In the future, when this functionality is augmented, we'll probably be saving
			 *	 them locally and syncng - X
			 */
			
			AppController *controller = [AppController sharedAppController];
			NSManagedObjectContext * moc = [controller managedObjectContext];
			NSEntityDescription *tryDeaEntity = [NSEntityDescription entityForName:@"TryDea" inManagedObjectContext:moc];

			for (NSDictionary *tryDeaDict in tryDeasJSONArray) {
				// TODO: put keys into extern vars
				TryDea *tryDea =(TryDea*)[[NSManagedObject alloc]initWithEntity:tryDeaEntity insertIntoManagedObjectContext:nil];
				tryDea.title = [tryDeaDict objectForKey:@"name"];
				tryDea.details = [tryDeaDict objectForKey:@"description"];
			    tryDea.server_id = [NSNumber numberWithInt:[[tryDeaDict objectForKey:@"ideaid"]intValue]];
			    tryDea.state = [NSNumber numberWithInt:state_remote]; //TODO - state!!!
				tryDea.numComments = [[tryDeaDict objectForKey:@"comment_count"]intValue];
                tryDea.team_size = [[tryDeaDict objectForKey:@"team_size_count"]intValue];
                 
				NSLog(@"Trydea %@ has %i comments, server_id: %i", tryDea.title, tryDea.numComments, [tryDea.server_id intValue]);
                
				[trydeas addObject:tryDea];
				[tryDea release];
			}
			
		}
	}@catch (NSException *exception) {
		[TryDeaUtils showAlertWithTitle:@"Error" andMessage:@"Could not load published ideas!"];
	}@finally {
		[parser release];
	}
	
	return trydeas;
}


-(IBAction)sortButtonClicked:(id)sender
{
    UIButton *button = (UIButton *)sender;
    UILabel *l1 = (UILabel *)[button viewWithTag:1];
    UILabel *l2 = (UILabel *)[button viewWithTag:2];
    l1.text = @"Sorted:";
    if (((UIButton *)sender).tag == SORT_BY_DATE_BUTTON_TAG) {
        if (currentSortingOrder == sortingOrderDateAsc) 
        {
            [self sortTrydeasWithOrder:sortingOrderDateDesc];
            l2.text = @"New to Old";
        }else
        {
            [self sortTrydeasWithOrder:sortingOrderDateAsc];
            l2.text = @"Old to New";
        }
    }else if(((UIButton *)sender).tag == SORT_BY_TITLE_BUTTON_TAG)
    {
        NSLog(@"Clicked the Sort By Name Button!");
        if (currentSortingOrder == sortingOrderAlphaAsc) {
            [self sortTrydeasWithOrder:sortingOrderAlphaDesc];
            l2.text = @"Z to A";
            
        }else
        {
            [self sortTrydeasWithOrder:sortingOrderAlphaAsc];
            l2.text = @"A to Z";
        }
    }else
    {
        
    }
    [button setTitle:@"" forState:UIControlStateNormal];

}
- (void)sortTrydeasWithOrder:(SortingOrder)so
{
    Boolean ascending;
    NSString *sortingKey;
    
    if (so == sortingOrderDateAsc) {
        sortingKey = @"server_id";
        ascending = YES;
    }else if(so == sortingOrderDateDesc)
    {
        sortingKey = @"server_id";
        ascending = NO;
    }else if(so == sortingOrderAlphaAsc)
    {
        sortingKey = @"title";
        NSLog(@"Sorting by alpha ASC");
        ascending = YES;
    }else
    {
        sortingKey = @"title";
        NSLog(@"Sorting by alpha DESC");

        ascending = NO;
    }
    
    NSSortDescriptor *sd;
    if (so == sortingOrderAlphaAsc  || so == sortingOrderAlphaDesc) {
        sd = [[NSSortDescriptor alloc] initWithKey:sortingKey ascending:ascending selector:@selector(localizedCaseInsensitiveCompare:)];
    }else
    {
        sd = [[NSSortDescriptor alloc]initWithKey:sortingKey ascending:ascending];
    }
    
    NSArray *sds = [NSArray arrayWithObject:sd]; 
    [tryDeaList sortUsingDescriptors:sds];
    [sortingKey release];
    [sd release];
    self.currentSortingOrder = so;
    [[self tableView] reloadData];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [tryDeaList count];
}



- (void)tableView:(UITableView*)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath*)indexPath
{
	NSLog(@"Accessory button tapped for %@", indexPath);

    if (![[TryDeaUtils defaultValueForKey:@"status"] isEqualToString:LOGGEDIN]) {
        [TryDeaUtils showAlertWithTitle:@"User not logged in" andMessage:@"Please log into your account to publish ideas!"];
        return;
	}else{
        self.currentAction = actionPublish;
        NSString *serverUrl = [NSString stringWithFormat:@"%@/%@/%@", [TryDeaUtils defaultValueForKey:tryDeaServerUrlVar], authorizedController, submitIdea];

        TryDea *tryDea = (TryDea*)[tryDeaList objectAtIndex:indexPath.row];
        self.tryDeaToBePublished = tryDea;
        NSLog(@"Publishing idea: %@", tryDea.details);
        
        if (self.tryDeaToBePublished.details.length < 3) {
            [TryDeaUtils showAlertWithTitle:@"Cannot publish empty trydea!" andMessage:@"Please fill in the details for this trydea before submitting it"];
        }else{
            NSDictionary* params = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    tryDea.title, @"name",
                                    tryDea.details, @"description",
                                    nil]; 
            SBJsonWriter *writer = [SBJsonWriter new];	
            NSString* paramString = [writer stringWithObject:params];
            NSData *data = [paramString dataUsingEncoding:NSUTF8StringEncoding];
            NSLog(@"PARAMS: %@", paramString);
            
            NSDictionary *headers;
            [writer release];
            headers = [self getAuthorizedHeaders];
            [self executeRequestToUrl:serverUrl withHeaders:headers andCurrentAction:actionPublish andData:data usingMethod:httpMethodPost]; 
        }
    }

}

- (IBAction)accessoryControlTapped:(UIControl*)control withEvent:(UIEvent*)event
{
	NSIndexPath* indexPath = [self indexPathForControl:control withEvent:event];
	if (indexPath != nil)
		[self.tableView.delegate tableView:self.tableView accessoryButtonTappedForRowWithIndexPath:indexPath];
}

- (NSIndexPath*)indexPathForControl:(UIControl*)control withEvent:(UIEvent*)event
{
	UITouch* touch = [[event touchesForView:control] anyObject];
	CGPoint point = [touch locationInView:self.tableView];
	return [self.tableView indexPathForRowAtPoint:point];
}

- (void)tableView: (UITableView*)tableView willDisplayCell: (UITableViewCell*)cell forRowAtIndexPath: (NSIndexPath*)indexPath
{
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

	//cell.backgroundColor = UIColorFromRGB(0x403639);
	if (indexPath.row % 2 == 0) {
		//cell.backgroundColor = UIColorFromRGB(0x4E4C4F);//0xA7A5A8);		
		cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"row1_left.png"]];
	}else{
		//cell.backgroundColor = UIColorFromRGB(0x6D6A6E);//0x868487);
		//cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"row2.png"]];
        cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"row2_left.png"]];
	}
	 
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *CellIdentifier = @"Cell";
	TryDea *td = [tryDeaList objectAtIndex:indexPath.row];
	
	NSLog(@"TryDea title: %@, state: %i, identifier: %@", td.title, [td.state intValue], CellIdentifier);
	
    TryDeaListCell* myCell = [TryDeaListCell cellForTable:tableView withOwner:self];
    UIButton *button = (UIButton*)[myCell.customAccessoryView viewWithTag:BUTTON_TAG];
    myCell.accessoryView = myCell.customAccessoryView;
    button.hidden = YES;
    myCell.accessoryView = myCell.customAccessoryView;
    
    UILabel *labelComments = (UILabel *)[myCell.editingAccessoryView viewWithTag:TRYDEA_COMMENTS_TAG];
    UILabel *labelNumComments = (UILabel *)[myCell.editingAccessoryView viewWithTag:NUM_COMMENTS_TAG];
    UILabel *labelTeam = (UILabel *)[myCell.editingAccessoryView viewWithTag:TRYDEA_TEAM_TAG];
    UILabel *labelNumTeam = (UILabel *)[myCell.editingAccessoryView viewWithTag:NUM_TEAM_TAG];
    
    NSLog(@"Trydea state: %i, title: %@", [td.state intValue], td.title);
    
    labelTeam.hidden = YES; 
    labelNumTeam.hidden = YES;
    labelComments.hidden = YES;
    labelNumComments.hidden = YES;
    
    if ([td.state intValue] == state_local) {
		CellIdentifier = @"CellForLocalTryDea";
        myCell.accessoryView = myCell.customAccessoryView;
        button.hidden = NO;
	}else
    {
        myCell.accessoryView = myCell.publishedCustomAccessoryView;
        UILabel *labelNumComments = (UILabel *)[myCell.accessoryView viewWithTag:NUM_COMMENTS_TAG];
        UILabel *labelNumTeam = (UILabel *)[myCell.accessoryView viewWithTag:NUM_TEAM_TAG];
        
        labelNumTeam.text = [NSString stringWithFormat:@"%i",td.team_size];
        labelNumComments.text = [NSString stringWithFormat:@"%i",td.numComments];
        
    }
    
    UIImageView *imageView = (UIImageView *)[myCell.accessoryView viewWithTag:RIGHT_BACKGROUND_IMAGE_TAG];
    if (indexPath.row % 2 == 0) {
        imageView.image = [UIImage imageNamed:@"row1_right.png"];
    }else
    {
        imageView.image = [UIImage imageNamed:@"row1_right.png"];
    }
    UILabel *label = (UILabel *)[myCell viewWithTag:TRYDEA_TITLE_TAG];
    label.text = td.title;
    label = (UILabel *)[myCell viewWithTag:TRYDEA_DETAIL_TAG];
    label.text = td.details;
    

    return myCell;
    }

# pragma mark private methods

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
		AppController *controller = [AppController sharedAppController];
		NSManagedObjectContext *moc = [controller managedObjectContext];
		TryDea *tryDea = [tryDeaList objectAtIndex:indexPath.row];
		[moc deleteObject:tryDea];
		[tryDeaList removeObjectAtIndex:indexPath.row];
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    TryDea* tryDea =[tryDeaList objectAtIndex:indexPath.row];
    NSLog(@"Trydea state: %i, state_local: %i", [tryDea.state intValue], state_local);
	if ([tryDea.state intValue] == state_local) {
        detailViewController = [[TryDeaDetailViewController alloc] init];
        detailViewController.tryDea = tryDea;
		detailViewController.controllerTitle = @"Totally TryDea";
		detailViewController.editing = YES;
		//	[tryDea release];
		[self.navigationController pushViewController:detailViewController animated:YES]; 
	}else{
        TryDeaExtensiveDetailViewController *myDetailViewController = [[TryDeaExtensiveDetailViewController alloc] init];
        myDetailViewController.tryDea = tryDea;
		myDetailViewController.currentAction = actionGetTryDea;
        [self.navigationController pushViewController:myDetailViewController animated:YES]; 
		
    }
	
}


#pragma mark -
#pragma mark NSURLConnection delegate methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	NSLog(@"Received response (I am in LIST Controller): %@", response);	
	[receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	NSLog(@"Received %d bytes of data (I am in List Controller)", [data length]); 
	
	[receivedData appendData:data];
	NSLog(@"Received data is now %d bytes (I am in List Controller)", [receivedData length]); 
	
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	NSLog(@"Error receiving response (I am in List Controller): %@", [error localizedDescription]);
    // TODO: better error message
    [receivedData release];
	[tryDeaHTTP release];
    if(self.tryDeaToBePublished)
    {
        [tryDeaToBePublished release];
		self.tryDeaToBePublished = nil;
    }
	[self.navigationItem.leftBarButtonItem setEnabled:YES];
    [TryDeaUtils showAlertWithTitle:@"Error" andMessage:@"Error communicating with the server"];
	AppController *appController = [AppController sharedAppController];
	[appController stopAnimation];
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	// Once this method is invoked, "responseData" contains the complete result
	NSLog(@"Succeeded! Received %d bytes of data (I am in List Controller)", [receivedData length]); 
	
	NSString *serverResponse=[[NSString alloc] initWithData:receivedData encoding:NSASCIIStringEncoding];
	NSLog(@"Succeeded! Received %@ bytes of data (I am in List Controller)", serverResponse); 
	
    if(currentAction == actionLoad){
        NSArray* tryDeas = [self parseJSONTryDeas:(NSString*)serverResponse];
		
		// I do it this way to make sure that I get the MOST updated version of 'trydea' on the server
		[tryDeaList removeAllObjects];
		
		for (TryDea* tryDea in tryDeas) {
			[tryDeaList addObject:tryDea];
        }
       
        // now add the tryDeas that are local. Yes. Again.
        AppController *appController = [AppController sharedAppController];
        NSArray *list = [appController allInstancesOf:@"TryDea" orderedBy:@"created_date"];
        
        for (TryDea* t in list) {
            [tryDeaList addObject:t];
        }
        
       
        [self sortTrydeasWithOrder:self.currentSortingOrder];
        // TODO: into a method
//        NSSortDescriptor *sd = [[NSSortDescriptor alloc]initWithKey:@"created_date" ascending:YES];
//        NSArray *sds = [NSArray arrayWithObject:sd];
//        [sd release];
//        [tryDeaList sortUsingDescriptors:sds];
//        [[self tableView] reloadData];
         //
        
        [tryDeas release];
        //[[self tableView]reloadData];        
	}else if(currentAction == actionPublish){        
        AppController *controller = [AppController sharedAppController];
		NSManagedObjectContext *moc = [controller managedObjectContext];
		[moc deleteObject:self.tryDeaToBePublished];
		[controller saveContext];
		[tryDeaList removeObject:self.tryDeaToBePublished];
        
    }else{
        
    }
	
	AppController *appController = [AppController sharedAppController];
	[appController stopAnimation];

	[serverResponse release];
	[receivedData release];
	[tryDeaHTTP release];
	[[self tableView] reloadData];
	[self.navigationItem.leftBarButtonItem setEnabled:YES];
	//it is here to avoid concurrency issues
	if (currentAction == actionPublish) {
		[self loadTryDeasFromServer:nil];
	}
}



#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
	if(detailViewController)
	{
		[detailViewController release];
	}
	[tryDeaList release];
	if(receivedData){
		[receivedData release];
	}
	if (tryDeaHTTP) {
		[tryDeaHTTP release];
	}
    if(tryDeaToBePublished)
    {
        [tryDeaToBePublished release];
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}




	    




@end

