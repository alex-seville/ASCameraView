//
//  assetLib.m
//  CameraLib
//
//  Created by Alexander Seville on 6/8/14.
//  Copyright (c) 2014 AlexSeville. All rights reserved.
//

#import "assetLib.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@implementation assetLib

//http://stackoverflow.com/a/10200857/1563800
- (void) getLatestImageWithSuccess:(void (^)(UIImage *image))onSuccess {
	ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
	
	[assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos
		usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
			 if (nil != group) {
				 // be sure to filter the group so you only get photos
				 [group setAssetsFilter:[ALAssetsFilter allPhotos]];
				 
				 
				 [group enumerateAssetsAtIndexes:[NSIndexSet indexSetWithIndex:group.numberOfAssets - 1] options:0
					  usingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
						  if (nil != result) {
							  ALAssetRepresentation *repr = [result defaultRepresentation];
							  
							  UIImage *img;
							  
							  //check the orientation, in case we need to flip
							  if (
								  repr.orientation == ALAssetOrientationUp ||
								  repr.orientation == ALAssetOrientationUpMirrored){
								  
								  // this is the most recent saved photo
								  img = [UIImage imageWithCGImage:[repr fullResolutionImage] scale:repr.scale orientation:UIImageOrientationRight];
							  } else if (repr.orientation == ALAssetOrientationDown ||
										 repr.orientation == ALAssetOrientationDownMirrored){
								  // this is the most recent saved photo
								  img = [UIImage imageWithCGImage:[repr fullResolutionImage] scale:repr.scale orientation:UIImageOrientationLeft];
							  } else if (repr.orientation == ALAssetOrientationLeft ||
										 repr.orientation == ALAssetOrientationLeftMirrored){
								  // this is the most recent saved photo
								  img = [UIImage imageWithCGImage:[repr fullResolutionImage] scale:repr.scale orientation:UIImageOrientationLeft];
							  } else if (repr.orientation == ALAssetOrientationRight ||
										 repr.orientation == ALAssetOrientationRightMirrored){
								  // this is the most recent saved photo
								  img = [UIImage imageWithCGImage:[repr fullResolutionImage] scale:repr.scale orientation:UIImageOrientationRight];
							  }
							  
							  
							  onSuccess(img);
							  // we only need the first (most recent) photo -- stop the enumeration
							  *stop = YES;
						  }
					  }];
			 }
			 
			 *stop = NO;
		 } failureBlock:^(NSError *error) {
			 NSLog(@"error: %@", error);
		 }];
}

- (void) saveImage:(UIImage *)imageToSave onCompletion:(void (^)(void))onCompletion {
	[[[ALAssetsLibrary alloc] init] writeImageToSavedPhotosAlbum:[imageToSave CGImage] orientation:(ALAssetOrientation)[imageToSave imageOrientation] completionBlock:^(NSURL *assetURL, NSError *error) {
		onCompletion();
	}];
}

@end