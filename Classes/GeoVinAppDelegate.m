//
//  GeoVinAppDelegate.m
//  GeoVin
//
//  Created by Xavier on 4/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GeoVinAppDelegate.h"
#import "GeoVinViewController.h"

@implementation GeoVinAppDelegate

@synthesize window;
@synthesize viewController;
@synthesize currentRegion;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.

    // Add the view controller's view to the window and display.
    [self.window addSubview:viewController.view];
    [self.window makeKeyAndVisible];
	
	// Initializaton...
	
	// Loads all the regions (path.id) from the .svg inside an array
	regionsArr = [[NSMutableArray alloc] init];
	regionsFoundArr = [[NSMutableArray alloc] init];
    [regionsArr addObject:@"Corse"];
    [regionsArr addObject:@"Lorraine"];
    [regionsArr addObject:@"Centre"];	
	[regionsArr addObject:@"Beaujolais"];
	[regionsArr addObject:@"Loire"];
	[regionsArr addObject:@"Bordelais"];
	[regionsArr addObject:@"SudOuest"];
	[regionsArr addObject:@"Jura"];
	[regionsArr addObject:@"Savoie"];
	[regionsArr addObject:@"Alsace"];
	[regionsArr addObject:@"Champagne"];
	[regionsArr addObject:@"Charentes"];
	[regionsArr addObject:@"Languedoc"];
	[regionsArr addObject:@"Provence"];
	[regionsArr addObject:@"Rhone"];
	[regionsArr addObject:@"Bourgogne"];
	[regionsArr addObject:@"Roussillon"];

	// Score
	score = 0;
	
	// Status
	paused = FALSE;

    return YES;
}




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
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


#pragma mark - Controller methods
// Impossible de faire marcher les @property et @synthetise sur ces fucking attributs non pointeur
- (BOOL)isPaused {
	return paused;
}

- (void)setPaused:(BOOL)status {
	paused = status;
}

- (int)getScore {
	return score;
}

- (NSString *)askNewRegion {
	NSString* region = @"";
	BOOL bFreshRegion = FALSE;
	
	// iterates through regionArr until a fresh region (not already found and different from currentRegion) is found 
	for (NSString *s in regionsArr) {
		if(![regionsFoundArr containsObject:s] && ![s isEqualToString:currentRegion]) 
		{
			bFreshRegion = TRUE;
			region = s;
			break;
		}
	}
	
	//set and return the current region
	currentRegion = region;
	return region;
}

-(BOOL)checkAnswerCorrect:(NSString* )region {
	
	//check if answer region in argument is correct regarding the current region
	
	// As region argument directly comes from svg path.id through JS, let's purge the string for '_X' after some region names
	NSString* regionPurged = region;
	NSRange match;
	match = [region rangeOfString: @"_"];
	
	// if _X found in string, remove it
	if (match.location != NSNotFound)
	{
		regionPurged = [region substringWithRange: NSMakeRange (0, match.location)];
	}
	
	if([regionPurged isEqualToString:currentRegion])
	{
		// add the region to the regionsFoundArr, increment score and return true
		[regionsFoundArr addObject:currentRegion];
		score++;
		return TRUE;
	}
	else
	{
		score--;
		return FALSE;
	}
}


- (void)dealloc {
    [viewController release];
    [window release];
	[regionsArr release];
	[regionsFoundArr release];
	[currentRegion release];
    [super dealloc];
}


@end
