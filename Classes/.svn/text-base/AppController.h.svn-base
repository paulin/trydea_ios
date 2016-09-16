//
//  tryDeaAppDelegate.h
//  tryDea
//
//  Created by Xenia Hertzenberg on 5/1/11.
//  Copyright 2011 Xenia H. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "LoadingView.h"

@interface AppController : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    
@private
    NSManagedObjectContext *managedObjectContext_;
    NSManagedObjectModel *managedObjectModel_;
    NSPersistentStoreCoordinator *persistentStoreCoordinator_;
	UIActivityIndicatorView *activityIndicator;
	LoadingView *loadingView;
	//UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) UINavigationController *navigationController;

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, retain) LoadingView *loadingView;

+ (AppController *) sharedAppController;
- (NSArray *)allInstancesOf:(NSString *) entityName orderedBy:(NSString *)attName;

- (NSURL *)applicationDocumentsDirectory;
- (void)saveContext;
- (void)startAnimation;
- (void)startAnimationWithLabel:(NSString *)label;
- (void)stopAnimation;

@end

