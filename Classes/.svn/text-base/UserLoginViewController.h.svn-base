//
//  UserLoginViewController.h
//  tryDea
//
//  Created by Xenia Hertzenberg on 3/26/12.
//  Copyright (c) 2012 Feline Infinity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TryDeaUtils.h"
#import "TryDeaHTTP.h"


@interface UserLoginViewController : UIViewController<UIAlertViewDelegate>
{
    UITextField                             *usernameField;
    UITextField                             *passwordField;
    UITextField                             *serverField;
    NSMutableData                           *receivedData;
    TryDeaHTTP                              *tryDeaHTTP;   
    bool                                    httpErrorHappened;


}


@property (nonatomic, retain) IBOutlet  UITextField *usernameField;
@property (nonatomic, retain) IBOutlet  UITextField *passwordField;
@property (nonatomic, retain) IBOutlet  UITextField *serverField;
@property (nonatomic, retain) NSMutableData *receivedData;
@property (nonatomic, retain) TryDeaHTTP *tryDeaHTTP;
@property  (nonatomic, assign) bool httpErrorHappened;

-(IBAction) login:(id)sender;
-(void)submitLoginRequestWithUsername:(NSString* )aUsername andPassword:(NSString *)aPassword andServer:(NSString* )aServer;
-(bool)validateUserEntries;
-(IBAction)userStartedToEdit:(id)sender;
-(IBAction)dismissKeyboard:(id)sender;
-(IBAction)forgotPasswordClicked:(id)sender;

@end
