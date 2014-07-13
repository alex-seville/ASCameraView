//
//  ASCameraView.m
//  CameraLib
//
//  Created by Alexander Seville on 6/14/14.
//  Copyright (c) 2014 AlexSeville. All rights reserved.
//

#import "ASCameraView.h"
#import "ASCamera.h"
#import <UIKit/UIKit.h>
#import "UIImage+ImageEffects.h"

@interface ASCameraView()

@property (nonatomic, strong) ASCamera *camera;

@property (nonatomic, strong) UIImageView *imageView2;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation ASCameraView

- (id)initWithFrame:(CGRect)frame
{
	NSLog(@"init view?");
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
		[self setupView];
		
		
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	NSLog(@"init with coder");
    if ((self = [super initWithCoder:aDecoder])) {
        [self setupView];
    }
    return self;
}

- (id) setupView {
	self.camera = [[ASCamera alloc] init];
	NSLog(@"Set up view");
	[self.camera showCameraWithPreviewView:self];
	
	return self;
}

- (void) recordWithCompletion:(void (^)(UIImage *mostRecent))onCompletion {
	[self.camera recordWithCompletion:onCompletion];
}

- (void) setFlashMode:(int)mode {
	[self.camera setFlashMode:mode];
}

- (void) changeCamera {
	
	/* can't get the blur effect on transition to work properly right now */
	
	/*
	UIGraphicsBeginImageContext(self.bounds.size);
	
	//[self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
	CGContextRef c = UIGraphicsGetCurrentContext();
	CGContextSaveGState(c);
	CGContextTranslateCTM(c, 0, 0);
	[self.layer renderInContext:c];
	CGContextRestoreGState(c);
	
	
	
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	
	self.imageView = [[UIImageView alloc] init];
	self.imageView.image = image;
	
	self.imageView2 = [[UIImageView alloc] init];
	//imageView2.image = [image applyBlurWithRadius:50 tintColor:[UIColor colorWithWhite:1.0 alpha:0.5] saturationDeltaFactor:1 maskImage:nil];
	self.imageView2.image = image;
	
	
	[self addSubview:self.imageView];
	[self bringSubviewToFront:self.imageView];
	
	//[self addSubview:imageView2];
	[self.imageView2.image applyLightEffect];
	*/
	
	//stop the preview during camera change
	[self.camera stopCamera];
	
	/*
	[UIView transitionFromView:self toView:self.imageView2
					  duration:1.0
					   options:UIViewAnimationOptionTransitionFlipFromRight
					completion:^(BOOL finished) {
						//[self.camera changeCamera];
						//[self.imageView2 removeFromSuperview];
						
					}];
	*/
	[UIView transitionWithView:self duration:0.75f options:UIViewAnimationOptionTransitionFlipFromRight animations:nil completion:^(BOOL finished)
	{
		[self.camera changeCamera];
	}];

	
	
	

}

- (bool) enableDeviceSwitching {
	return [self.camera enableDeviceSwitching];
}

@end
