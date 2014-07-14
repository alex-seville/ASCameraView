//
//  ASCameraViewPickerController.h
//  ASCameraViewPickerController
//
//  Created by Alexander Seville on 6/6/14.
//  Copyright (c) 2014 AlexSeville. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@protocol ASCameraViewPickerControllerDelegate;

NSString *const ASCameraViewPickerControllerMediaType;
NSString *const ASCameraViewPickerControllerOriginalImage;
NSString *const ASCameraViewPickerControllerEditedImage;
NSString *const ASCameraViewPickerControllerCropRect;
NSString *const ASCameraViewPickerControllerMediaURL;
NSString *const ASCameraViewPickerControllerReferenceURL;
NSString *const ASCameraViewPickerControllerMediaMetadata;

@interface ASCameraViewPickerController : UIViewController

//Main view properties
@property (nonatomic, strong) UIColor *backgroundColor;

//Thumbnails
@property (nonatomic, assign) BOOL disableThumbnail;

//Focusing
@property (nonatomic, assign) BOOL disableFocusOverlay;
@property (nonatomic, strong) UIImage *focusOverlayImage;

//delegate
@property (nonatomic, weak) id<ASCameraViewPickerControllerDelegate> delegate;


@end

//ASCameraViewPickerControllerDelegate delegate protocl

@protocol ASCameraViewPickerControllerDelegate <NSObject>
@optional

- (void)imagePickerController:(ASCameraViewPickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info;

- (void)imagePickerControllerDidCancel:(ASCameraViewPickerController *)picker;

@end // end of delegate protocol
