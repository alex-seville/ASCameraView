//
//  ASCameraView.m
//  CameraLib
//
//  Created by Alexander Seville on 6/14/14.
//  Copyright (c) 2014 AlexSeville. All rights reserved.
//

#import "ASCameraView.h"
#import "ASCamera.h"

@interface ASCameraView()

@property (nonatomic, strong) ASCamera *camera;

@end

@implementation ASCameraView

- (id)initWithFrame:(CGRect)frame
{
	NSLog(@"init view?");
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
		[self setupView];
		
		
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	NSLog(@"init with coder");
    if ((self = [super initWithCoder:aDecoder])) {
        [self setupView];
    }
    return self;
}

- (id) setupView {
	self.camera = [[ASCamera alloc] init];
	NSLog(@"Set up view");
	[self.camera showCameraWithPreviewView:self];
	
	return self;
}

@end
