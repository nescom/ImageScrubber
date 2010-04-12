//
//  ImageScrubberAppDelegate.m
//  ImageScrubber
//
//  Created by Nikita Ivanyushchenko on 4/7/10.
//  Copyright MLS-Automatization 2010. All rights reserved.
//

#import "ImageScrubberAppDelegate.h"
#import "ImageScrubberViewController.h"

@implementation ImageScrubberAppDelegate

@synthesize window;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions 
{    
	viewController = [[ImageScrubberViewController alloc] initWithNibName:@"ImageScrubberViewController" bundle:nil];
	viewController.view.frame = window.frame;
	[window addSubview:viewController.view];
	[window makeKeyAndVisible];
    return YES;
}

- (void)dealloc 
{
    [viewController release];
    [super dealloc];
}

@end

