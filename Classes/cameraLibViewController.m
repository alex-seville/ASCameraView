//
//  cameraLibViewController.m
//  CameraLib
//
//  Created by Alexander Seville on 6/6/14.
//  Copyright (c) 2014 AlexSeville. All rights reserved.
//

#import "cameraLibViewController.h"
#import "cameraLib.h"
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface cameraLibViewController ()
@property (nonatomic, strong) cameraLib *cameraLibrary;

@end

@implementation cameraLibViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	self.view.backgroundColor = [UIColor grayColor];
	
}

- (void)viewDidAppear{
	self.cameraLibrary = [[cameraLib alloc] init];
	//[self.cameraLibrary showCameraWithPreviewView:self.liveDisplayView];
	NSLog(@"Set up view controller");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
