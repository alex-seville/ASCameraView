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

@implementation cameraLib

// Demo function just for proof of concept and to show
// that this lib is consumable
- (void) showCameraWithPreviewView:(UIView *) previewView {
	AVCaptureSession *session = [[AVCaptureSession alloc] init];
	
	
	//add video device
	AVCaptureDevice *VideoDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
	if (VideoDevice)
	{
		NSError *error;
		AVCaptureDeviceInput *VideoInputDevice = [AVCaptureDeviceInput deviceInputWithDevice:VideoDevice error:&error];
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
	
	//preview layer
	NSLog(@"Adding video preview layer");
	AVCaptureVideoPreviewLayer *previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:session];
	NSLog(@"Display the preview layer");
	CGRect layerRect = [[previewView layer] bounds];
	[previewLayer setBounds:layerRect];
	[previewLayer setPosition:CGPointMake(CGRectGetMidX(layerRect),
										  CGRectGetMidY(layerRect))];
    [previewView.layer addSublayer:previewLayer];
	
	//start capture
	NSLog(@"Starting capture");
	[session startRunning];
}

@end
