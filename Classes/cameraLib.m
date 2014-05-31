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


- (void) showCameraWithPreviewView:(UIView *) previewView {
	AVCaptureSession *session = [[AVCaptureSession alloc] init];
	
	AVCaptureVideoPreviewLayer *previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:session];
	
	previewLayer.frame = previewView.bounds; // Assume you want the preview layer to fill the view.
	[previewView.layer addSublayer:previewLayer];
}

@end
