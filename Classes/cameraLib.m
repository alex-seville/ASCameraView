//
//  cameraLib.m
//  cameraLib
//
//  Created by Alexander Seville on 5/31/14.
//  Copyright (c) 2014 AlexSeville. All rights reserved.
//

#import "cameraLib.h"
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface cameraLib()

@property (nonatomic, strong) AVCaptureDevice *device;
@property (nonatomic, strong) UIImageView *focusingOverlay;
@property (nonatomic, strong) UIView *consumerView;


@property (nonatomic, assign) BOOL isFocusOverlayShown;
@property (nonatomic, strong) UIImage *focusOverlayImage;


@end

@implementation cameraLib

@synthesize session;

bool focusing = false;
bool finishedFocus = false;

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

#pragma mark - public methods

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
					//capture focusing
					NSLog(@"set up focus observing");
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



// Demo function just for proof of concept and to show
// that this lib is consumable
- (void) showCameraWithPreviewView:(UIView *) previewView showFocusOverlay:(BOOL)showFocusOverlay focusOverlayImage:(UIImage *)focusOverlayImage {
	
	self.isFocusOverlayShown = showFocusOverlay;
	self.focusOverlayImage = focusOverlayImage;
		
	self.consumerView = previewView;
	[self setupVideoCapture];
	
	
	//preview layer
	NSLog(@"Adding video preview layer");
	AVCaptureVideoPreviewLayer *previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:session];
	NSLog(@"Display the preview layer");
	CGRect layerRect = [[self.consumerView layer] bounds];
	NSLog(@"bounds: %f %f %f %f", layerRect.size.width, layerRect.size.height, layerRect.origin.x, layerRect.origin.y);
	
	previewLayer.frame = self.consumerView.bounds;
	
	previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
	[self.consumerView.layer addSublayer:previewLayer];
	
	//start capture
	NSLog(@"Starting capture");
	[session startRunning];
	
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	NSLog(@"in observer");
    if( [keyPath isEqualToString:@"adjustingFocus"] ){
        [self isFocusing:change];
    }
}

- (void) isFocusing:(NSDictionary *)change {
	BOOL adjustingFocus = [ [change objectForKey:NSKeyValueChangeNewKey] isEqualToNumber:[NSNumber numberWithInt:1] ];
	
	if (adjustingFocus) {
		focusing=true;
		NSLog(@"FOCUSING");
		[self showFocusOverlay];
	}
	else {
		if (focusing) {
			focusing = false;
			finishedFocus = true;
			NSLog(@"DONE FOCUSING");
			[self hideFocusOverlay];
		}
	}
}


- (void) showFocusOverlay {
	//When the camera is autofocusing, the square is just shown in the middle
	if (self.focusingOverlay == nil){
		NSLog(@"creating focusing overlay");
		self.focusingOverlay = [[UIImageView alloc] initWithImage:self.focusOverlayImage];
		NSLog(@"image loaded? %f", self.focusingOverlay.image.size.width);
	}
	if (self.consumerView != nil){
		NSLog(@"getting center of consumer view");
		self.focusingOverlay.center = [self.consumerView convertPoint:self.consumerView.center fromView:self.consumerView.superview];
		NSLog(@"adding focusing overlay to parent view");
		self.focusingOverlay.alpha = 0.0f;
		[self.consumerView addSubview:self.focusingOverlay];
		
		[UIView animateWithDuration:0.25 animations:^() {
			self.focusingOverlay.alpha = 1.0f;
		}];

	}
}

- (void) hideFocusOverlay {
	if (self.consumerView != nil && self.focusingOverlay != nil){
		NSLog(@"removing focusing overlay");
		[UIView animateWithDuration:0.25 animations:^() {
			self.focusingOverlay.alpha = 0.0f;
		} completion:^(BOOL finished) {
			[self.focusingOverlay removeFromSuperview];
		}];
		
	}
}

@end
