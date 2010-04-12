//
//  ImageScrubberViewController.h
//
//  Created by Nikita Ivanyushchenko on 4/8/10.
//  Copyright 2010 MLS-Automatization. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "ImageScrubberToolbarDelegate.h"

@class ImageScrubberToolbar;

@interface ImageScrubberViewController : UIViewController <ImageScrubberToolbarDelegate>
{
    IBOutlet ImageScrubberToolbar *imageScrubberToolbar;
}

-(void)imageSelected:(int) anIndex;
@end
