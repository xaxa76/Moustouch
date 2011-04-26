//
//  GeoVinViewController.m
//  GeoVin
//
//  Created by Xavier on 4/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GeoVinViewController.h"
#import "GeoVinAppDelegate.h"

@implementation GeoVinViewController

@synthesize webView;
@synthesize labelRegion;
@synthesize labelScore;
@synthesize labelScoreVal;
@synthesize buttonStart;

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


#pragma mark - Delegate methods

/* Delegate of webView:shouldStartLoadWithRequest:navigationType: - allows to call Objective C from JS 
	http://www.icodeblog.com/2008/12/19/iphone-coding-learning-about-uiwebviews-by-creating-a-web-browser/
	http://www.codingventures.com/2008/12/using-uiwebview-to-render-svg-files/
 */
- (BOOL)webView:(UIWebView *)webView
	shouldStartLoadWithRequest:(NSURLRequest *)request
	navigationType:(UIWebViewNavigationType)navigationType 
{
	
	NSString *requestString = [[request URL] absoluteString];
	NSArray *components = [requestString componentsSeparatedByString:@":"];
	
	if ([components count] > 1 && 
		[(NSString *)[components objectAtIndex:0] isEqualToString:@"myapp"]) {
		if([(NSString *)[components objectAtIndex:1] isEqualToString:@"myfunction"]) 
		{
			// Get the JS arguments
			NSString *arg1 = [components objectAtIndex:2];
			
			// Process answer
			GeoVinAppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
			if([appDelegate checkAnswerCorrect:arg1])
			{
				//good answer, refresh view with next region and score
				[self updateLabelsWithRegion:[appDelegate askNewRegion] andScore:[appDelegate getScore]];
                
                
                NSString *jsCommand = [NSString stringWithFormat:@"validate('%@');",arg1];
                [self.webView stringByEvaluatingJavaScriptFromString:jsCommand];
                
                
			}
			else
			{
				//wrong answer, refresh view with current region score
				[self updateLabelsWithRegion:[appDelegate currentRegion] andScore:[appDelegate getScore]];
			}
			
		}
		return NO;
	}
	
	return YES; // Return YES to make sure regular navigation works as expected.
}


#pragma mark - UIViewController methods

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {

	// Loading the SVG file from resources folder
	NSString *filePath = [[NSBundle mainBundle]
						  pathForResource:@"carteregionvin" ofType:@"svg"];
	NSData *svgData = [NSData dataWithContentsOfFile:filePath];
						  
	NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
	NSURL *baseURL = [[NSURL alloc] initFileURLWithPath:resourcePath isDirectory:YES];
						
	[self.webView 	loadData:svgData 
				MIMEType:@"image/svg+xml"	
				textEncodingName:@"UTF-8" 
				baseURL:baseURL];	
	
	[baseURL release];
	
		
    [super viewDidLoad];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

#pragma mark - Target Action methods

-(IBAction)startButtonPressed:(id)sender {
	
	GeoVinAppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
	
	//Start button pressed
	if([self.buttonStart.titleLabel.text isEqualToString:@"Start"])
	{
		[self.buttonStart setTitle:@"Stop"
						  forState:UIControlStateNormal];
		
		if([appDelegate isPaused])
		{
			// if game was paused then don't ask for new region
			[appDelegate setPaused:FALSE];
			[self updateLabelsWithRegion: [appDelegate currentRegion] andScore: [appDelegate getScore]];
		}
		else 
		{
			[self updateLabelsWithRegion: [appDelegate askNewRegion] andScore: [appDelegate getScore]];
		}

	}
	//Stop button pressed
	else 
	{
		// Set pause status and update view
		[appDelegate setPaused:TRUE];
		[self updateLabelsWithRegion: @"Paused!" andScore: [appDelegate getScore]];
		[self.buttonStart setTitle:@"Start"
						  forState:UIControlStateNormal];
	}

}

-(IBAction)nextButtonPressed:(id)sender {
	
	// Ask for a new questin and update view
	GeoVinAppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
	[self updateLabelsWithRegion:[appDelegate askNewRegion] andScore:[appDelegate getScore]];	
	
}



#pragma mark - View update methods


-(void)updateLabelsWithRegion:(NSString*)region andScore:(int)score {
	// Update labels
	if([region isEqualToString:@""])
	{
		self.labelRegion.text = @"Finished!";
		self.labelScoreVal.text  = [NSString stringWithFormat:@"%d", score];
	}
	else
	{
		self.labelRegion.text = region;
		self.labelScoreVal.text  = [NSString stringWithFormat:@"%d", score];
	}
}


- (void)dealloc {
	[webView release];
	[labelRegion release];
	[labelScore release];
	[labelScoreVal release];
	[buttonStart release];
	
    [super dealloc];

}

@end
