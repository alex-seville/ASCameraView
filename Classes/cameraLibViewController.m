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
@property (unsafe_unretained, nonatomic) IBOutlet UIView *liveDisplayView;

@end

@implementation cameraLibViewController

- (id)init
{
	NSString *nibName = @"cameraLibViewController";
    NSBundle *bundle = nil;
    self = [super initWithNibName:nibName bundle:bundle];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    // Disregard parameters - nib name is an implementation detail
	return [self init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	self.cameraLibrary = [[cameraLib alloc] init];
	NSLog(@"Set up view controller");
	[self.cameraLibrary showCameraWithPreviewView:self.liveDisplayView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
