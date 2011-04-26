//
//  GeoVinViewController.h
//  GeoVin
//
//  Created by Xavier on 4/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GeoVinViewController : UIViewController<UIWebViewDelegate> {
	
	IBOutlet UIWebView *webView;
	IBOutlet UILabel *labelRegion;
	IBOutlet UILabel *labelScore;
	IBOutlet UILabel *labelScoreVal;
	IBOutlet UIButton *buttonStart;
}

-(IBAction)startButtonPressed:(id)sender;
-(IBAction)nextButtonPressed:(id)sender;
-(void)updateLabelsWithRegion:(NSString*)region andScore:(int)score;

@property(nonatomic,retain) UIWebView *webView;
@property(nonatomic,retain) UILabel *labelRegion;
@property(nonatomic,retain) UILabel *labelScore;
@property(nonatomic,retain) UILabel *labelScoreVal;
@property(nonatomic,retain) UIButton *buttonStart;
@end

