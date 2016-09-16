//
//  tryDeaAppDelegate.m
//  tryDea
//
//  Created by Xenia Hertzenberg on 5/1/11.
//  Copyright 2011 Xenia H. All rights reserved.
//

#import "AppController.h"
#import "TryDeaListViewController.h"
#import "AboutViewController.h"
#import "TryDeaUtils.h"
#import "TrydeaAboutViewController.h"
#import "TryDeaSettingsViewController.h"
#import "QSStrings.h"
#import "FlurryAnalytics.h"

static AppController* sharedInstance;

@implementation AppController

@synthesize window, navigationController, activityIndicator, loadingView;



#pragma mark -
#pragma mark Application lifecycle


- (id) init
{
	if (sharedInstance) {
		NSLog(@"Error");
	}
	if (self=[super init]) {
        sharedInstance = self;
    }
	return self;
}

- (void)addController:(UIViewController*)controller toControllersArray:(NSMutableArray*)controllers withTabName:(NSString*)tabName
{
	UINavigationController *myNavigationController = [[UINavigationController alloc] initWithRootViewController:controller];
	UITabBarItem *tbi = [myNavigationController tabBarItem];
	[tbi setTitle:tabName];
	
	UINavigationBar *bar = [controller.navigationController navigationBar];	
	
	[bar setBarStyle:UIBarStyleBlack];
	[bar setTranslucent:NO];
	[bar setTintColor:[UIColor blackColor]];
	
	[controllers addObject:myNavigationController];
	[myNavigationController release];
	myNavigationController = nil; 
	
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
	NSLog(@" in didFinishLaunchingWithOptions");
    [FlurryAnalytics startSession:TRYDEA_FLURRY_API_KEY];
	
	
	
	UITabBarController *tabBarController = [[UITabBarController alloc]init];
	NSMutableArray *controllers = [[NSMutableArray alloc]init];
	
	TryDeaListViewController *tlvc = [[TryDeaListViewController alloc]init];
	[self addController:tlvc toControllersArray:controllers withTabName:@"Your Ideas"];
	[tlvc release];
	
	//SettingsViewController *svc = [[SettingsViewController alloc]init];	
	//[self addController:svc toControllersArray:controllers withTabName:@"Settings"];
	TryDeaSettingsViewController *svc = [[TryDeaSettingsViewController alloc]init];
    [self addController:svc toControllersArray:controllers withTabName:@"Settings"];
    
	TrydeaAboutViewController *avc = [[TrydeaAboutViewController alloc]init];
	[self addController:avc toControllersArray:controllers withTabName:@"About"];
	
	[avc release];
	[svc release];
	
	[tabBarController setViewControllers:controllers];
	[window setRootViewController:tabBarController];
	[tabBarController release];
	
	[self.window makeKeyAndVisible];
	
    [controllers release];
    
    // empty out tentative values on the new registration screen
    [TryDeaUtils setDefaultValue:@"" forKey:@"tentativeSignupCode"];
    [TryDeaUtils setDefaultValue:@"" forKey:@"tentativeUsername"];
    [TryDeaUtils setDefaultValue:@"" forKey:@"tentativePassword"];
    [TryDeaUtils setDefaultValue:@"" forKey:@"tentativePasswordConfirm"];
    [TryDeaUtils setDefaultValue:@"" forKey:@"tentativeEmail"];
    [TryDeaUtils setDefaultValue:@"" forKey:@"tentativeServerUrl"];   
	return YES;
}


/*
 - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
 
 
 NSLog(@"Application: %@", [application description]);
 [window setRootViewController:navigationController];
 
 UITabBarController *tabBarController = [[UITabBarController alloc]init];
 
 TryDeaListViewController *tlvc = [[TryDeaListViewController alloc]init];
 navigationController = [[UINavigationController alloc] initWithRootViewController:tlvc];
 [tlvc release];
 
 SettingsViewController *svc = [[SettingsViewController alloc]init];
 AboutViewController *avc = [[AboutViewController alloc]init];
 NSArray *controllers = [NSArray arrayWithObjects:navigationController, svc, avc, nil];
 
 
 [avc release];
 [svc release];
 
 [tabBarController setViewControllers:controllers];
 [window setRootViewController:tabBarController];
 [tabBarController release];
 [self.window makeKeyAndVisible];
 
 return YES;
 
 }
 */


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
    [self saveContext];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of the transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


/**
 applicationWillTerminate: saves changes in the application's managed object context before the application terminates.
 */
- (void)applicationWillTerminate:(UIApplication *)application {
    [self saveContext];
}


- (void)saveContext {
    
    NSError *error = nil;
	NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}    


#pragma mark -
#pragma mark Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext {
    
    if (managedObjectContext_ != nil) {
        return managedObjectContext_;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext_ = [[NSManagedObjectContext alloc] init];
        [managedObjectContext_ setPersistentStoreCoordinator:coordinator];
    }
    return managedObjectContext_;
}


/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel {
    
    if (managedObjectModel_ != nil) {
        return managedObjectModel_;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"tryDea" withExtension:@"momd"];
    managedObjectModel_ = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];    
    return managedObjectModel_;
}


/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    
    if (persistentStoreCoordinator_ != nil) {
        return persistentStoreCoordinator_;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"tryDea.sqlite"];
    
    NSError *error = nil;
    persistentStoreCoordinator_ = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![persistentStoreCoordinator_ addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES],NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return persistentStoreCoordinator_;
}

- (NSArray *)allInstancesOf:(NSString *)entityName orderedBy:(NSString *)attName
{
	// get the context
	NSManagedObjectContext *moc = [[AppController sharedAppController] managedObjectContext];
	
	// fetch request to fetch from 'entityName'
	NSFetchRequest *fetch = [[NSFetchRequest alloc]init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:moc];
	[fetch setEntity:entity];
	
	// and now we want to sort
	if(attName)
	{
		NSSortDescriptor *sd = [[NSSortDescriptor alloc]initWithKey:attName ascending:YES];
		NSArray *sortDescriptors = [NSArray arrayWithObject:sd];
		[sd release];
		
		[fetch setSortDescriptors:sortDescriptors];
	}
	
	// all this hard work... but will it actually fetch?
	NSError *error;
	NSArray *result = [moc executeFetchRequest:fetch error:&error];
	[fetch release];
	
	//
	if(!result)
	{
		NSLog(@"Error: %@", [error localizedDescription]);
	}
	
	return result;
}


#pragma mark -
#pragma mark Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    
    [managedObjectContext_ release];
    [managedObjectModel_ release];
    [persistentStoreCoordinator_ release];
    
    [window release];
    [super dealloc];
}

-(void)startAnimation
{
	/*
	activityIndicator = [[[UIActivityIndicatorView alloc] initWithFrame:CGRectMake((self.window.frame.size.width / 2) - 15, (self.window.frame.size.height / 2), 30, 30)] retain];
	activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
	activityIndicator.hidesWhenStopped = YES;
	[self.window addSubview:activityIndicator];
	[activityIndicator startAnimating];
	 */
	
	self.loadingView = [LoadingView loadingViewInView:[self.window.subviews objectAtIndex:0] withLabel:@""];
}
-(void)startAnimationWithLabel:(NSString*)label
{
	/*
	 activityIndicator = [[[UIActivityIndicatorView alloc] initWithFrame:CGRectMake((self.window.frame.size.width / 2) - 15, (self.window.frame.size.height / 2), 30, 30)] retain];
	 activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
	 activityIndicator.hidesWhenStopped = YES;
	 [self.window addSubview:activityIndicator];
	 [activityIndicator startAnimating];
	 */
	
	self.loadingView = [LoadingView loadingViewInView:[self.window.subviews objectAtIndex:0] withLabel:label];
}

-(void)stopAnimation
{
	/*
	[loadingView
	 performSelector:@selector(removeView)
	 withObject:nil
	 afterDelay:1.0];
	 */
	
	[loadingView performSelectorOnMainThread:@selector(removeView) withObject:nil waitUntilDone:YES];
}
+ (AppController *)sharedAppController
{
	return sharedInstance;
}

@end

