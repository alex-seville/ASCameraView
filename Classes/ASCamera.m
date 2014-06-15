//
//  ASCamera.m
//  ASCamera
//
//  Created by Alexander Seville on 5/31/14.
//  Copyright (c) 2014 AlexSeville. All rights reserved.
//

#import "ASCamera.h"
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "assetLib.h"

@interface ASCamera()

/* AVCapture objects */
@property (nonatomic, strong) AVCaptureDevice *device;
@property (nonatomic, strong) AVCaptureStillImageOutput *stillImageOutput;

/* Configurations objects */

//the view used to display the camera feed
@property (nonatomic, strong) UIView *consumerView;
//our focusing overlay UIImageView.  This is displayed when the camera changes focuse.
@property (nonatomic, strong) UIImageView *focusingOverlay;
//you can hide the focus overlay if you want
@property (nonatomic, assign) BOOL isFocusOverlayShown;
//you can customize the overlay image asset
@property (nonatomic, strong) UIImage *focusOverlayImage;




@end

@implementation ASCamera

@synthesize session;

#pragma mark - Local Variables

//used for focus state
bool focusing = false;
bool finishedFocus = false;
CGPoint focusPoint;
bool focusOnPoint = false;



#pragma mark Singleton Methods

+ (id)sharedManager {
    static AVCaptureSession *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
	if (self = [super init]) {
		session = [[AVCaptureSession alloc] init];
	}
	return self;
}

- (void)dealloc {
	// Should never be called, but just here for clarity really.
}


#pragma mark - Public Methods

// show a default camera view controller without focusing overlay
- (void) showCameraWithPreviewView:(UIView *) previewView {
	[self showCameraWithPreviewView:previewView showFocusOverlay:false focusOverlayImage:nil];
}


// show a camera view controller with parameters to control which options are enabled
- (void) showCameraWithPreviewView:(UIView *) previewView showFocusOverlay:(BOOL)showFocusOverlay focusOverlayImage:(UIImage *)focusOverlayImage {
	
	//we can't show an overlay if an oevrlay image isn't provided
	//this may change when I figure out how to do the iOS7 focusing animation
	self.isFocusOverlayShown = focusOverlayImage != nil && showFocusOverlay;
	self.focusOverlayImage = focusOverlayImage;
		
	//this is the actual view that will show the camera feed
	//in most cases it will be the ASCameraViewController's preview view
	//but it could be any view
	self.consumerView = previewView;
	
	//set up the media capture
	//TODO: this could be refactored to be more logical
	//and to have better error handling
	[self setupVideoCapture];
	
	
	//Create the preview layer and attach it to the consumer view
	AVCaptureVideoPreviewLayer *previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:session];
	NSLog(@"setting up preview layer");
	//set the size to match the consumer view
	previewLayer.frame = self.consumerView.bounds;
	
	previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
	[self.consumerView.layer addSublayer:previewLayer];
	
	//by default we're going to capture an image (for now)
	self.stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
	if ([session canAddOutput:self.stillImageOutput])
	{
		[self.stillImageOutput setOutputSettings:@{AVVideoCodecKey : AVVideoCodecJPEG}];
		[session addOutput:self.stillImageOutput];
		
	}
	NSLog(@"start capture");
	
	//start capture
	[session startRunning];
	
}

//take a picture or record a video
- (void) recordWithCompletion:(void (^)(UIImage *mostRecent))onCompletion{
	NSLog(@"record");
	[self.stillImageOutput captureStillImageAsynchronouslyFromConnection:[self. stillImageOutput connectionWithMediaType:AVMediaTypeVideo] completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
		
		NSLog(@"error? %@", error);
		
		if (imageDataSampleBuffer)
		{
			NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
			UIImage *image = [[UIImage alloc] initWithData:imageData];
			NSLog(@"got a ui image to save");
			[[[assetLib alloc] init] saveImage:image onCompletion:^{
				onCompletion(image);
			}];
		}
	}];
}

#pragma mark - private methods

- (void) setupVideoCapture {
	_device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
	if (_device)
	{
		NSError *error;
		AVCaptureDeviceInput *VideoInputDevice = [AVCaptureDeviceInput deviceInputWithDevice:_device error:&error];
		if (!error)
		{
			if ([session canAddInput:VideoInputDevice])
			{
				[session addInput:VideoInputDevice];
				
				if (self.isFocusOverlayShown){
					//capture focusing by observing changes to the device focusing
					[_device addObserver:self forKeyPath:@"adjustingFocus" options:NSKeyValueObservingOptionNew context:nil];
				}
			}
			else{
				NSLog(@"Couldn't add video input");
			}
		}
		else
		{
			NSLog(@"Couldn't create video input");
		}
	}
	else
	{
		NSLog(@"Couldn't create video capture device");
	}
}


// Handler for observations
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if( [keyPath isEqualToString:@"adjustingFocus"] ){
        [self isFocusing:change];
    }
}

- (void) isFocusing:(NSDictionary *)change {
	BOOL adjustingFocus = [ [change objectForKey:NSKeyValueChangeNewKey] isEqualToNumber:[NSNumber numberWithInt:1] ];
	
	if (adjustingFocus) {
		focusing=true;
		//NSLog(@"FOCUSING");
		[self showFocusOverlay];
	}
	else {
		if (focusing) {
			focusing = false;
			finishedFocus = true;
			//NSLog(@"DONE FOCUSING");
			[self hideFocusOverlay];
		}
	}
}


- (void) showFocusOverlay {
	//When the camera is autofocusing, the square is just shown in the middle
	//we always reset this object, in case we're modified the frame
	//NSLog(@"creating focusing overlay");
	self.focusingOverlay = [[UIImageView alloc] initWithImage:self.focusOverlayImage];
	//NSLog(@"image loaded? %f", self.focusingOverlay.image.size.width);
	
	if (self.consumerView != nil){
		if (focusOnPoint){
			//center the overlay on the point that was tapped
			self.focusingOverlay.center = focusPoint;
			
			//now we decrease the width by half, and the height by half,
			//but also the x, and y so that things are still centered
			
			double halfWidth = self.focusingOverlay.frame.size.width/2;
			double halfHeight = self.focusingOverlay.frame.size.height/2;
			self.focusingOverlay.frame = CGRectMake(self.focusingOverlay.frame.origin.x+(halfWidth/2), self.focusingOverlay.frame.origin.y+(halfHeight/2), halfWidth ,halfHeight);
			
			
			//the device tends to focus twice, so we set a timer
			[NSTimer scheduledTimerWithTimeInterval:2.0
											 target:self
										   selector:@selector(endFocusOnPoint)
										   userInfo:nil
											repeats:NO];
			
		}else{
			//NSLog(@"getting center of consumer view");
			self.focusingOverlay.center = [self.consumerView convertPoint:self.consumerView.center fromView:self.consumerView.superview];
			//NSLog(@"adding focusing overlay to parent view");
		}
		self.focusingOverlay.alpha = 0.0f;
		[self.consumerView addSubview:self.focusingOverlay];
		
		[UIView animateWithDuration:0.25 animations:^() {
			self.focusingOverlay.alpha = 1.0f;
		}];

	}
}

- (void) hideFocusOverlay {
	if (self.consumerView != nil && self.focusingOverlay != nil){
		//NSLog(@"removing focusing overlay");
		[UIView animateWithDuration:0.25 animations:^() {
			self.focusingOverlay.alpha = 0.0f;
		} completion:^(BOOL finished) {
			[self.focusingOverlay removeFromSuperview];
		}];
		
	}
}

- (void) endFocusOnPoint {
	focusOnPoint = false;
}

- (void) focusOnPoint:(CGPoint)autoFocusPoint {
	NSLog(@"got tap on preview");
	if ([_device isFocusModeSupported:AVCaptureFocusModeContinuousAutoFocus] &&
		[_device isFocusPointOfInterestSupported] ) {
		NSLog(@"locking to make changes to focus point %f %f", autoFocusPoint.x, autoFocusPoint.y);
		[_device lockForConfiguration:nil];
		[_device setFocusPointOfInterest:autoFocusPoint];
		focusPoint = autoFocusPoint;
		focusOnPoint = true;
		NSLog(@"changed focus, resetting mode");
		[_device setFocusMode:AVCaptureFocusModeContinuousAutoFocus];
		[_device unlockForConfiguration];
	}

}

@end
