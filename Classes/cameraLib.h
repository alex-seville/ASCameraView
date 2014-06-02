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

+ (id)sharedManager;


//for demonstration purposes
- (void) showCameraWithPreviewView:(UIView *) previewView;



@end
