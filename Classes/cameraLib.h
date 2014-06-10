//
//  cameraLib.h
//  cameraLib
//
//  Created by Alexander Seville on 5/31/14.
//  Copyright (c) 2014 AlexSeville. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface cameraLib : NSObject {
    AVCaptureSession *session;
}

@property (nonatomic, strong) AVCaptureSession *session;

// used to ensure this lib is a singleton
+ (id)sharedManager;


// this function exposes all the default functions and is called by cameraLibViewController
// it can also be consumed directly, if someone wants to use their own viewController
- (void) showCameraWithPreviewView:(UIView *) previewView showFocusOverlay:(BOOL)showFocusOverlay focusOverlayImage:(UIImage *)focusOverlayImage;

// default version
- (void) showCameraWithPreviewView:(UIView *) previewView;

//focus on a point
- (void) focusOnPoint:(CGPoint)autoFocusPoint;

- (void) recordWithCompletion:(void (^)(UIImage *mostRecent))onCompletion;



@end
