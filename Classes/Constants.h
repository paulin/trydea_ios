//
//  Constants.h
//  tryDea
//
//  Created by Xenia Hertzenberg on 5/4/11.
//  Copyright 2011 Xenia H. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TryDeaErrorCodes.h"


#define DEFAULT_TRYDEA_URL  @"http://trydea.heroku.com" //@"http://trydea.com"
#define tryDeaServerUrlVar  @"tryDeaServerUrl"
#define PUGETWORKS_TAG 7
#define PUGETWORKS_URL @"http://www.pugetworks.com"
#define THINKTANK_TAG  9
#define THINKTANK_URL  @"http://seattlethinktank.com"
#define SORT_BY_DATE_BUTTON_TAG 11
#define SORT_BY_TITLE_BUTTON_TAG 13

//Flurry
#define FLURRY_PROD_ID   @"8EWL3LRGC95KVRY2W4AU"  //Used for integration to Flurry
#define FLURRY_DEV_ID    @"8EWL3LRGC95KVRY2W4AU"  //Used for integration to Flurry
#define TRYDEA_FLURRY_API_KEY  FLURRY_DEV_ID

#define ERROR_MESSAGE_LOGIN_TO_VIEW_PUBLISHED_TRYDEAS   @"To view or published ideas, please login into your account in settings"

#define ERROR_MESSAGE_WRONG_SERVER(serverUrl)           [NSString stringWithFormat:@"Server responded with an error. Please make sure %@ is a correct server url and try again", serverUrl]

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define GREEN_COLOR             UIColorFromRGB(0x00CC00);
#define FEEDBACK_EMAIL_ADDRESS  @"trydea@pugetworks.com"
#define LOGOFF_NOTIFICATION     @"UserLoggedOff"

typedef enum {
	httpMethodGet,
	httpMethodPost
} httpMethod;

typedef enum {
	actionLogin,
	actionLoad,
	actionPublish, 
    actionGetTryDea,
	actionSubmitComment,
	actionShowComment,
	actionLeaveTeam,
    actionJoinTeam
} HttpAction;

typedef enum{
    titleSection = 0,
  //  descriptionSection,
    teamSection,
    commentsSection,
    leaveFeedbackSection
} tryDeaDetailSection;

typedef enum{
    typeSection = 0,
    authorSection,
    commentTextSection
} commentDetailSection;

typedef enum {
    sortingOrderDateAsc = SORT_BY_DATE_BUTTON_TAG ,
    sortingOrderDateDesc,
    sortingOrderAlphaAsc = SORT_BY_TITLE_BUTTON_TAG,
    sortingOrderAlphaDesc
} SortingOrder;



extern int const state_local;
extern int const state_remote;
extern int const login_success;
extern int const login_failure;

//TODO: put servers there: staging, test and real
extern NSString *server;
extern NSString *mobileGatewayAuth;
extern NSString *getUserInfo;
extern NSString *mobileGatewayOpen; 
extern NSString *newUserRegister;
extern NSString *authorizedController;
extern NSString *getIdeas;
extern NSString *loadPublishedIdeasOnOpenApp;
extern NSString *submitIdea;
extern NSString *getIdea;
extern NSString *submitComment;
extern NSString *joinTeam;
extern NSString *leaveTeam;




//private static final String REGISTER_URI = OPEN_CONTROLLER + "/register";	
//private static final String FORGOT_PASSWORD_URI = OPEN_CONTROLLER + "/forgot_password";
//
//private static final String USER_INFO_URI = AUTHORIZED_CONTROLLER + "/get_user_info";
//private static final String SUBMIT_IDEA_URI = AUTHORIZED_CONTROLLER + "/submit_idea";


//extern NSString *forgotPassword;
extern NSString *forgotPassword;
//extern const NSString *username;
//extern const NSString *password;
//extern NSString *status;

extern NSString *LOGGEDIN;
extern NSString *LOGGEDOUT;

