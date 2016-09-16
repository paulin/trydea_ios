//
//  TryDeaUtils.m
//  tryDea
//
//  Created by Xenia Hertzenberg on 6/6/11.
//  Copyright 2011 Xenia H. All rights reserved.
//

#import "TryDeaUtils.h"
#import "QSStrings.h"
#import "Constants.h"
#import "JSON.h"
#import "NSData+Base64.h"

@implementation TryDeaUtils

+(NSString *)getEncodedStringForUsername:(NSString *)username password:(NSString *)password
{
	NSString *encodeMe = [NSString stringWithFormat:@"%@:%@", username, password];
	NSData *data = [encodeMe dataUsingEncoding:NSASCIIStringEncoding];
	NSString *encoded = [data base64EncodedString];
	
	//NSString *encoded = [QSStrings encodeBase64WithString:encodeMe];
    return encoded;
}

// TODO: make private
+(NSString *)sendSynchronousRequestToServer:(NSString*)serverUrl withData:(NSData*)data andMethod:(httpMethod)method 
								 andHeaders:(NSDictionary *)headers storeErrorIn:(NSError **)error
{
	NSURL* url = [NSURL URLWithString:serverUrl];
	NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
	
	if (method == httpMethodPost)
	{
		[request setHTTPMethod:@"POST"];
	}else if(method == httpMethodGet)
	{
		[request setHTTPMethod:@"GET"];
	}else {
		[request setHTTPMethod:@"GET"]; // maybe more options in the future
	}
	
	// set the headers
	for( NSString *h in headers )
	{
		NSLog(@"putting in header %@, value: %@", h, [headers objectForKey:h]);
		[request setValue:[headers objectForKey:h] forHTTPHeaderField:h];		
	}
	[request setHTTPBody:data];
	
	
	NSHTTPURLResponse* response;
	NSData * responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:error];      
	NSString *responseBody = [[NSString alloc] initWithData:responseData encoding:NSASCIIStringEncoding];
	NSLog(@"RESPONSE: %@", responseBody);
	return responseBody;
	
}

+(int) getUserInfoWithAuthHeader:(NSString* )authHeader forServer:(NSString *)serverUrl returningResponse:(NSString**)response
{
	NSLog(@"Authorizing with header %@", authHeader);
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSLog(@"AUTH URL: %@", serverUrl);
	NSLog(@"Auth: %@:%@", [defaults stringForKey:@"username"],[defaults stringForKey:@"password"]);
	
	NSString *authHeaderValue = [NSString stringWithFormat: @"Basic %@", authHeader];
	NSDictionary* headers = [[NSDictionary alloc] initWithObjectsAndKeys:
							 authHeaderValue ,@"Authorization",
							 nil];
	NSError *error = nil;						 
	NSString *authResponseBody = [self sendSynchronousRequestToServer:serverUrl withData:nil andMethod:httpMethodGet andHeaders:headers storeErrorIn:&error];
	NSLog(@"RESPONSE: %@", authResponseBody);
	[headers release];
	
	
	if (error == nil) {
		*response = authResponseBody;
		return NO_ERROR;
		
	}else{
		*response = [error localizedDescription];
		return ERROR_GENERAL;
	}
}

+(void)logOut
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults]; 
    [defaults setObject:LOGGEDOUT forKey:@"status"];
    [defaults setObject:@"" forKey:@"username"];
    [defaults setObject:@"" forKey:@"password"];

}

+(int)registerNewUser:(NSString*)username withPassword:(NSString*)password andEmail:(NSString*)email andSignUpCode:(NSString*)signUpCode toServerUrl:(NSString*)tryDeaServerUrl returningResponse:(NSString**)response
{
    NSLog(@"Server: %@", tryDeaServerUrl);
	NSDictionary *headers = [[NSDictionary alloc] initWithObjectsAndKeys:
							 @"application/json",@"Accept",
							 @"application/json",@"Content-type",
							 nil];
	
	NSDictionary *newUserInfo = [[NSDictionary alloc] initWithObjectsAndKeys:
								 signUpCode,@"signUpCode",
								 email,@"email",
								 username,@"username",
								 password, @"password",
								 nil];
	
	
	SBJsonWriter *writer = [SBJsonWriter new];	
	NSString* jsonString = [writer stringWithObject:newUserInfo];
	NSLog(@"jsonString: %@", jsonString);
	
	NSString *serverUrl = [NSString stringWithFormat:@"%@/%@/%@", tryDeaServerUrl, mobileGatewayOpen, newUserRegister];
	NSLog(@"server URL: %@", serverUrl);
	NSData *data = [jsonString dataUsingEncoding:NSASCIIStringEncoding]; 
	
	NSError *error = nil;
	NSString *responseBody = [self sendSynchronousRequestToServer:serverUrl withData:data andMethod:httpMethodPost andHeaders:headers storeErrorIn:&error];
    [newUserInfo release];
    [writer release];
    [headers release];
    
    
    if (![TryDeaUtils validateJSON:responseBody]) {
        NSLog(@"returned something weird from server: %@", responseBody);
        return ERROR_WRONG_SERVER;
    }
    
    SBJsonParser *parser = [[SBJsonParser alloc]init];
    
    @try{ 
        NSDictionary *parsedResponse =[parser objectWithString:responseBody error:&error];
        NSString *status =[parsedResponse objectForKey:@"status" ];
        if ([status isEqualToString:@"success"]) 
        {  
            *response = responseBody;
            [TryDeaUtils setDefaultValue:tryDeaServerUrl forKey:tryDeaServerUrlVar];
            return NO_ERROR;
        }else
        {
            *response = [error localizedDescription];
            return ERROR_GENERAL;
        }
    }@catch(NSException * e){
        NSLog(@"Parser could not parse this response, error %@", [error localizedDescription]);
        NSLog(@"Exception reads: %@", [e description]);
        *response = [e description];
        return ERROR_GENERAL;
    }@finally {
        [parser release];
    }	
}
+(int) submitIdeaWithTitle:(NSString *)ideaTitle andDescription:(NSString *)description andAuthHeader:(NSString *)authHeader
{
	return 0;
}

/*
 yes if jsonStr is indeed in json format. NO otherwise
 */
+(BOOL)validateJSON:(NSString *)jsonStr
{
    NSError *error;
    if([NSJSONSerialization JSONObjectWithData:[jsonStr dataUsingEncoding:NSASCIIStringEncoding] options:kNilOptions error:&error] == nil)
    {
        return NO;
    }  
    return YES;
}
+(BOOL)validateURL:(NSString *)url
{
    NSDataDetector *detect = [[NSDataDetector alloc] initWithTypes:NSTextCheckingTypeLink error:nil];
    NSArray *matches = [detect matchesInString:url options:0 range:NSMakeRange(0, [url length])];
    NSLog(@"%@", matches);
   
    return ([matches count] > 0);
}

+(NSString *)extractURL:(NSString *)tentativeUrl
{
    NSDataDetector *detect = [[NSDataDetector alloc] initWithTypes:NSTextCheckingTypeLink error:nil];
    NSArray *matches = [detect matchesInString:tentativeUrl options:0 range:NSMakeRange(0, [tentativeUrl length])];
    NSLog(@"%@", matches);
    if([matches count] > 0)
    {
        
        NSTextCheckingResult *match = [matches objectAtIndex:0];
        NSLog(@"Match: %@", [[match URL] description]);
        return [[match URL] description];
    }else
    {
        return @"";
    }
}

// http://stackoverflow.com/questions/800123/best-practices-for-validating-email-address-in-objective-c-on-ios-2-0
+ (BOOL) validateEmail: (NSString *) email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"; 
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex]; 
	
    return [emailTest evaluateWithObject:email];
}

+(void)setDefaultValue:(NSString*)value forKey:(NSString*)key
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:value forKey:key];
}

+(NSString*)defaultValueForKey:(NSString*)key
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults valueForKey:key];
}

+(void)showAlertWithTitle:(NSString *)title andMessage:(NSString*)message
{
    
	UIAlertView *alert = [[UIAlertView alloc]
						  initWithTitle:title 
						  message: message
						  delegate: nil
						  cancelButtonTitle:@"OK"
						  otherButtonTitles:nil];
	[alert show];
	[alert release];
	
}




@end
