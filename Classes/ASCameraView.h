//
//  ASCameraView.h
//  CameraLib
//
//  Created by Alexander Seville on 6/14/14.
//  Copyright (c) 2014 AlexSeville. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASCameraView : UIView

typedef enum ASCameraViewFlashMode {
	AUTO = 0,
	ON = 1,
	OFF = 2
} ASCameraViewFlashMode;

- (void) recordWithCompletion:(void (^)(UIImage *mostRecent))onCompletion;

- (void) setFlashMode:(int)mode;

- (void) changeCamera;

- (bool) enableDeviceSwitching;

@end
