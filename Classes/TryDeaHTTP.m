//
//  TryDeaHTTP.m
//  tryDea
//
//  Created by Xenia Hertzenberg on 8/14/11.
//  Copyright 2011 Xenia H. All rights reserved.
//

#import "TryDeaHTTP.h"


@implementation TryDeaHTTP
@synthesize receivedData;

- init {
    if ((self = [super init])) {
		
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}


- (void)setDelegate:(id)myDelegate
{
    delegate = myDelegate;
}

- (id)delegate
{
    return delegate;
}

- (void) executeRequesttoUrl:(NSString *)serverUrl withHeaders:(NSDictionary *)headers andData:(NSData *)data usingMethod:(httpMethod)method
{
	NSLog (@"executin'request: %@", serverUrl);	
	//self.receivedData = [[NSMutableData alloc] init];
	
	NSURL *myUrl = [NSURL URLWithString:serverUrl];
	NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:myUrl];
	
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
	[request setTimeoutInterval:10];
	[request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
	
	NSURLConnection *connection = [[NSURLConnection alloc]
								   initWithRequest:request
								   delegate:self.delegate
								   startImmediately:YES];
	// TODO: handle error
	if(!connection) {
		NSLog(@"connection failed :(");
	} else {
		NSLog(@"connection succeeded  :)");
		
	}
	
	[connection release];
	[headers release]; 	
}

- (void)get:(NSString *)serverUrl 
{
	
	NSLog (@"executin' GET: %@", serverUrl);	
	self.receivedData = [[NSMutableData alloc] init];
	
	
	
	NSURLRequest *request = [[NSURLRequest alloc]
							 initWithURL: [NSURL URLWithString:serverUrl]
							 cachePolicy: NSURLRequestReloadIgnoringLocalCacheData
							 timeoutInterval: 10
							 ];
	
	NSURLConnection *connection = [[NSURLConnection alloc]
								   initWithRequest:request
								   delegate:self.delegate
								   startImmediately:YES];
	// TODO: handle error
	if(!connection) {
		NSLog(@"connection failed :(");
        [request release];
	} else {
		NSLog(@"connection succeeded  :)");
		[request release];
		[connection release];
		
	}
	
//	[connection release];
//	[request release];  
//	[receivedData release];  
}


- (void)post: (NSString *)urlString {
	
	// POST
	//[request setHTTPMethod:@"POST"];
	// NSString *postString = @"Some post string";
	//[request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
}	

#pragma mark NSURLConnection delegate methods

//- (NSURLRequest *)connection:(NSURLConnection *)connection
//			 willSendRequest:(NSURLRequest *)request
//			redirectResponse:(NSURLResponse *)redirectResponse {
//	NSLog(@"Connection received data, retain count");
//	return request;
//}


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
	//[[NSAlert alertWithError:error] runModal];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	// Once this method is invoked, "responseData" contains the complete result
	NSLog(@"Succeeded! Received %d bytes of data", [receivedData length]); 
	
	NSString *dataStr=[[NSString alloc] initWithData:receivedData encoding:NSASCIIStringEncoding];
	NSLog(@"Succeeded! Received %@ bytes of data", dataStr); 
	
	if ([delegate respondsToSelector:@selector(didFinishDownload)]) {
		NSLog(@"Calling the delegate"); 
		//NSString* dataAsString = [[[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding] autorelease];
		[delegate performSelector:@selector(didFinishDownload) withObject: dataStr];
	}	
	[dataStr release];
}

- (void)didFinishDownload
{
	NSLog(@"Merci, download finished");
}



@end
