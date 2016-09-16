//
//  TryDeaUtils.h
//  tryDea
//
//  Created by Xenia Hertzenberg on 6/6/11.
//  Copyright 2011 Xenia H. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TryDeaErrorCodes.h"

@interface TryDeaUtils : NSObject {
}

+(NSString *)getEncodedStringForUsername:(NSString *)username password:(NSString *)password;
+(int)getUserInfoWithAuthHeader:(NSString* )authHeader forServer:(NSString *)serverUrl returningResponse:(NSString**)response;
+(int)submitIdeaWithTitle:(NSString *)ideaTitle andDescription:(NSString *)description andAuthHeader:(NSString *)authHeader;
+(void)logOut;
+(int)registerNewUser:(NSString*)username withPassword:(NSString*)password andEmail:(NSString*)email andSignUpCode:(NSString*)signUpCode toServerUrl:(NSString*)tryDeaServerUrl returningResponse:(NSString**)response;
+(BOOL) validateEmail: (NSString *)email;
+(BOOL)validateURL:(NSString *)url;
+(NSString *)extractURL:(NSString *)tentativeUrl;
+(BOOL)validateJSON:(NSString *)jsonStr;
+(void)setDefaultValue:(NSString*)value forKey:(NSString*)key;
+(NSString*)defaultValueForKey:(NSString*)key;
+(void)showAlertWithTitle:(NSString *)title andMessage:(NSString*)message;

@end

