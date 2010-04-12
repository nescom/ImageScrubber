//
//  ImageScrubberAppDelegate.h
//  ImageScrubber
//
//  Created by Nikita Ivanyushchenko on 4/7/10.
//  Copyright MLS-Automatization 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ImageScrubberViewController;

@interface ImageScrubberAppDelegate : NSObject <UIApplicationDelegate>
{
	UIWindow * window;
    ImageScrubberViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow * window;

@end
