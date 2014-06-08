//
//  assetLib.h
//  CameraLib
//
//  Created by Alexander Seville on 6/8/14.
//  Copyright (c) 2014 AlexSeville. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface assetLib : NSObject

- (void) getLatestImageWithSuccess:(void (^)(UIImage *image))onSuccess;

@end
