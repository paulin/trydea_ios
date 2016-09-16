//
//  Constants.m
//  tryDea
//
//  Created by Xenia Hertzenberg on 5/4/11.
//  Copyright 2011 Xenia H. All rights reserved.
//
#import "Constants.h"
#import "TryDeaErrorCodes.h"


int const state_local = 1;
int const state_remote = 0;
int const login_success = NO_ERROR;
int const login_failure = ERROR_FAILED_LOGIN;

//#define server [TryDeaUtils defaultValueForKey:tryDeaServerUrlVar]
NSString *server = @"http://trydea.herokuuuuuuuu.com";
//NSString *server = @"heroku.trydea.com";
NSString *mobileGatewayAuth = @"mobile_gateway_authorized";
NSString *mobileGatewayOpen = @"mobile_gateway_open";
NSString *getUserInfo = @"get_user_info";
NSString *newUserRegister = @"register";
//NSString *forgotPassword = @"forgot_password";
NSString *forgotPassword =@"users/password/new";
NSString *authorizedController= @"mobile_gateway_authorized";;
NSString *getIdeas = @"list_idea_statuses";
NSString *submitIdea =  @"submit_idea";
NSString *getIdea = @"get_idea";
NSString *submitComment = @"add_comment";
NSString *joinTeam = @"join_team";
NSString *leaveTeam = @"leave_team";



NSString *LOGGEDIN = @"LoggedIn";
NSString *LOGGEDOUT = @"LoggedOut";

NSString *loadPublishedIdeasOnOpenApp = @"loadPublishedIdeasOnOpenApp";
//NSString *username = @"username";
//NSString *password = @"password";
//NSString *status = @"status";