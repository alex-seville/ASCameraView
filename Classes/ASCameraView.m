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
#import <UIImage+BlurredFrame.h>

@interface ASCameraView()

@property (nonatomic, strong) ASCamera *camera;

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
	/* convert the current feed to a UIImage so we can blur it */
	UIGraphicsBeginImageContext(self.bounds.size);
	[self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	/* blur the captured image */
	CGRect frame = CGRectMake(0, image.size.height, image.size.width, image.size.height);
	image = [image applyLightEffectAtFrame:frame];
	
	
	/* do an animation to switch the view */
	[UIView  beginAnimations: @"SwitchDevice" context: nil];
    [UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.75];
    /* switch the camera */
	[self.camera changeCamera];
	
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self cache:NO];
    [UIView commitAnimations];

}

- (bool) enableDeviceSwitching {
	return [self.camera enableDeviceSwitching];
}

@end
