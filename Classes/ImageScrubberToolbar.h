//
//  ImageScrubberToolbar.h
//
//  Created by Nikita Ivanyushchenko on 4/7/10.
//  Copyright 2010 MLS-Automatization. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "ImageScrubberToolbarDelegate.h"

@interface ImageScrubberToolbar : UIToolbar
{
    IBOutlet id<ImageScrubberToolbarDelegate> delegate;
	NSArray * imagesArray;
	NSMutableArray * imageViewsArray;
	UIImageView * selectionImageView;
	int position;
	int left;
}
@property (nonatomic, retain) id<ImageScrubberToolbarDelegate> delegate;
-(void) setImagesArray:(NSArray *) array;
-(void) rebuild;
@end
