//
//  ImageScrubberViewController.m
//
//  Created by Nikita Ivanyushchenko on 4/8/10.
//  Copyright 2010 MLS-Automatization. All rights reserved.
//

#import "ImageScrubberViewController.h"
#import "ImageScrubberToolbar.h"

@implementation ImageScrubberViewController

-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{	
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
	{
	}
	return self;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
{
    // Overriden to allow any orientation.
    return YES;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
	[imageScrubberToolbar rebuild];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
	[super viewDidLoad];
	
	NSString * resourcePath = [[NSBundle mainBundle] resourcePath];
	
	
	NSArray * imagesArray = [NSArray arrayWithObjects:	[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",resourcePath,@"Nature/Aurora.jpg"]],	
							 [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",resourcePath,@"Nature/Gentle Rapids.jpg"]],
							 [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",resourcePath,@"Nature/Ladybug.jpg"]],
							 [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",resourcePath,@"Nature/Pond Reeds.jpg"]],
							 [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",resourcePath,@"Nature/Rock Garden.jpg"]],
							 [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",resourcePath,@"Nature/Rocks.jpg"]],
							 [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",resourcePath,@"Nature/Snow Leopard Prowl.jpg"]],
							 [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",resourcePath,@"Nature/Snow Leopard.jpg"]],
							 [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",resourcePath,@"Nature/Snowy Hills.jpg"]],
							 [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",resourcePath,@"Nature/Stones.jpg"]],
							 [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",resourcePath,@"Nature/Summit.jpg"]],
							 [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",resourcePath,@"Nature/Tahoe.jpg"]],
							 [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",resourcePath,@"Nature/Tranquil Surface.jpg"]],
							 [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",resourcePath,@"Nature/Water.jpg"]],
							 [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",resourcePath,@"Nature/Zebra.jpg"]],
							 nil];													 
	
	[imageScrubberToolbar setImagesArray:imagesArray];
}

- (void)dealloc 
{
    [imageScrubberToolbar release];
    [super dealloc];
}

-(void)imageSelected:(int) anIndex
{
	NSLog(@"Image at index %i selected",anIndex);
}

@end
