//
//  ASCamera.h
//  ASCamera
//
//  Created by Alexander Seville on 5/31/14.
//  Copyright (c) 2014 AlexSeville. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ASCamera : NSObject {
    AVCaptureSession *session;
}

@property (nonatomic, strong) AVCaptureSession *session;

// used to ensure this lib is a singleton
+ (id)sharedManager;


- (void) showCameraWithPreviewView:(UIView *) previewView showFocusOverlay:(BOOL)showFocusOverlay focusOverlayImage:(UIImage *)focusOverlayImage;

// default version
- (void) showCameraWithPreviewView:(UIView *) previewView;

//focus on a point
- (void) focusOnPoint:(CGPoint)autoFocusPoint;

- (void) recordWithCompletion:(void (^)(UIImage *mostRecent))onCompletion;

- (void) setFlashMode:(int)mode;

- (void) changeCamera;

- (bool) enableDeviceSwitching;

@end
