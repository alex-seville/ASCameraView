//
//  cameraLibViewController.h
//  CameraLib
//
//  Created by Alexander Seville on 6/6/14.
//  Copyright (c) 2014 AlexSeville. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface cameraLibViewController : UIViewController

//Main view properties
@property (nonatomic, strong) UIColor *backgroundColor;

//Thumbnails
@property (nonatomic, assign) BOOL disableThumbnail;

//Focusing
@property (nonatomic, assign) BOOL disableFocusOverlay;
@property (nonatomic, strong) UIImage *focusOverlayImage;


@end
