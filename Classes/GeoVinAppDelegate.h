//
//  GeoVinAppDelegate.h
//  GeoVin
//
//  Created by Xavier on 4/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GeoVinViewController;

@interface GeoVinAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    GeoVinViewController *viewController;
	NSMutableArray *regionsArr;
	NSMutableArray *regionsFoundArr;
	NSString* currentRegion;
	int score;
	BOOL paused;
}
-(NSString *) askNewRegion;
-(BOOL)checkAnswerCorrect:(NSString* )region;
-(int)getScore;
-(BOOL)isPaused;
-(void)setPaused:(BOOL)status;
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet GeoVinViewController *viewController;
@property (nonatomic, retain) NSString* currentRegion;

@end

