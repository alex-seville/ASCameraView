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


@end

@implementation cameraLib

@synthesize session;

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
				[session addInput:VideoInputDevice];
			else
				NSLog(@"Couldn't add video input");
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
- (void) showCameraWithPreviewView:(UIView *) previewView {
		
	[self setupVideoCapture];
	
	
	//preview layer
	NSLog(@"Adding video preview layer");
	AVCaptureVideoPreviewLayer *previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:session];
	NSLog(@"Display the preview layer");
	CGRect layerRect = [[previewView layer] bounds];
	NSLog(@"bounds: %f %f %f %f", layerRect.size.width, layerRect.size.height, layerRect.origin.x, layerRect.origin.y);
	
	previewLayer.frame = previewView.bounds;
	
	previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
	[previewView.layer addSublayer:previewLayer];
	
	//start capture
	NSLog(@"Starting capture");
	[session startRunning];
	
}

@end
