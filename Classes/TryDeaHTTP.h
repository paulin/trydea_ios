//
//  TryDeaHTTP.h
//  tryDea
//
//  Created by Xenia Hertzenberg on 8/14/11.
//  Copyright 2011 Xenia H. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"


@interface TryDeaHTTP : NSObject {
	id delegate;
	NSMutableData *receivedData;
	NSURL *url;
}
@property (nonatomic,retain) NSMutableData *receivedData;
@property (retain) id delegate;

- (void)get: (NSString *)serverUrl;
- (void)post: (NSString *)serverUrl;
- (void)didFinishDownload;
- (void) executeRequesttoUrl:(NSString *)serverUrl withHeaders:(NSDictionary *)headers andData:(NSData*)data usingMethod:(httpMethod)method;

@end
