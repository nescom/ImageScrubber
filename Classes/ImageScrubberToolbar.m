//
//  ImageScrubberToolbar.m
//
//  Created by Nikita Ivanyushchenko on 4/7/10.
//  Copyright 2010 MLS-Automatization. All rights reserved.
//

static const float SMALL_SIZE	= 60.f;
static const float LARGE_SIZE	= 100.f;
static const float SIZE_DIF		= 20.f;
static const float ANIMATION_DURATION = 0.2f;

#import "ImageScrubberToolbar.h"
#import "ImageScrubberToolbarDelegate.h"

@interface ImageScrubberToolbar()
-(int) checkTouchPosition:(CGPoint) aPoint;
-(void) slideSelectionToPoint:(CGPoint) aTouchPoint;
-(void) calculateLeftAndUpdatePositions:(BOOL) rotated; // when rebuilding after setting new array or after rotating, pass YES.
-(void) updatePositions;
@end


@implementation ImageScrubberToolbar
@synthesize delegate;

- (id)initWithCoder:(NSCoder *)aDecoder
{
	if ((self = [super initWithCoder:aDecoder]))
	{
		// Custom initialization
		imageViewsArray = [[NSMutableArray alloc] init];
		
		//setting custom height
		[self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y - 56, self.frame.size.width, 100)];
		
		selectionImageView = [[UIImageView alloc] initWithImage:nil];
		selectionImageView.contentMode = UIViewContentModeScaleAspectFit;
		[self addSubview:selectionImageView];
		
		left = 0;
	}
	return self;
}

-(void) setImagesArray:(NSArray *) array
{
	if (imagesArray != array)
	{
		//release old array of images
		[imagesArray release];

		//remove old image views
		for (UIImageView * v in imageViewsArray)
		{
			[v removeFromSuperview];
		}
		[imageViewsArray removeAllObjects];

		//set new array of images
		imagesArray = [array retain];
		
		//calculate margins	
		for (int i=0; i<[imagesArray count]; i++)
		{
			UIImage * img = [imagesArray objectAtIndex:i];
			
			//create new image view
			UIImageView * imgView = [[UIImageView alloc] initWithImage:img];
			[imageViewsArray addObject:imgView];
			[self addSubview:imgView];
			
			//disallow user interaction with image view
			imgView.userInteractionEnabled = NO;
			imgView.contentMode = UIViewContentModeScaleAspectFit;
			//set position
		}
		[self bringSubviewToFront:selectionImageView];
		position = 0;
		[selectionImageView setImage:[imagesArray objectAtIndex:position]];
		
		float w = [imagesArray count]*SMALL_SIZE + 2.f*SIZE_DIF;
		left = (self.frame.size.width - w)/2.f;
		
		[self rebuild];
	}
}

-(void) rebuild
{
	[self calculateLeftAndUpdatePositions:YES];
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	if ([touches count] != 1)
	{
		return;
	}
	
	UITouch * touch = [touches anyObject];
	CGPoint p = [touch locationInView:self];
	[self slideSelectionToPoint:p];
}

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	if ([touches count] != 1)
	{
		return;
	}
	
	UITouch * touch = [touches anyObject];
	CGPoint p = [touch locationInView:self];
	
	[self slideSelectionToPoint:p];
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	if ([touches count] != 1)
	{
		return;
	}
			
	[delegate imageSelected:position];
}

-(void) calculateLeftAndUpdatePositions:(BOOL) rotated
{
	float w = [imagesArray count]*SMALL_SIZE + 2.f*SIZE_DIF;
	
	BOOL calculated = NO;
	if (w > self.frame.size.width)
	{
		UIView * v = [self.subviews objectAtIndex:position];
		if (v.frame.origin.x + SMALL_SIZE + SIZE_DIF > self.frame.size.width)
		{
			left = self.frame.size.width - (position + 1)*SMALL_SIZE - SIZE_DIF;
			calculated = YES;
		}
		else if (v.frame.origin.x < SIZE_DIF)
		{
			left = -position*SMALL_SIZE + SIZE_DIF;
			calculated = YES;
		}
	}
	if (rotated && !calculated)
	{
		left = (self.frame.size.width - w + SMALL_SIZE)/2.f;
		if (left < SIZE_DIF)
		{
			left = SIZE_DIF;
		}
	}
	[selectionImageView setImage:[imagesArray objectAtIndex:position]];
	[self updatePositions];
}



-(void) updatePositions
{
	float topMargin = (self.frame.size.height - SMALL_SIZE)/2.f;	
	
	[UIView beginAnimations:nil context:NULL];  
    [UIView setAnimationDuration:ANIMATION_DURATION];  
	
	for (int i=0; i<[imagesArray count];i++)
	{
		UIView * subview = [[self subviews] objectAtIndex:i];
		subview.frame = CGRectMake(left + SMALL_SIZE*i,
								   topMargin,
								   SMALL_SIZE,
								   SMALL_SIZE);
	}
	[selectionImageView setFrame:CGRectMake(left + SMALL_SIZE*position - SIZE_DIF,
											0,
											LARGE_SIZE,
											LARGE_SIZE)];
    [UIView commitAnimations];
}

-(int) checkTouchPosition:(CGPoint) aPoint
{
//	float topMargin = (self.frame.size.height - SMALL_SIZE)/2.f;
	
	return (aPoint.x - left)/SMALL_SIZE;	
}

-(void) slideSelection
{
	[self calculateLeftAndUpdatePositions:NO];
}

-(void) slideSelectionToPoint:(CGPoint) aTouchPoint
{	
	position = [self checkTouchPosition:aTouchPoint];
	if (position < 0)
	{
		position = 0;
	}
	else if (position > [imagesArray count] - 1)
	{
		position = [imagesArray count] - 1;
	}
	
	[self calculateLeftAndUpdatePositions:NO];
}
@end
