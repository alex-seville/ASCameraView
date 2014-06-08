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
							  // this is the most recent saved photo
							  UIImage *img = [UIImage imageWithCGImage:[repr fullResolutionImage]];
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

@end