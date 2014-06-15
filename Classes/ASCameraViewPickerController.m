//
//  ASCameraViewPickerController.m
//  ASCameraViewPickerController
//
//  Created by Alexander Seville on 6/6/14.
//  Copyright (c) 2014 AlexSeville. All rights reserved.
//

#import "ASCameraViewPickerController.h"
#import "ASCameraView.h"
#import <UIKit/UIKit.h>

@interface ASCameraViewPickerController ()


@end

@implementation ASCameraViewPickerController

- (id)init
{
	NSString *nibName = @"ASCameraViewPickerController";
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
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible: NO];
	[[UIApplication sharedApplication] setStatusBarHidden:YES];
    // Do any additional setup after loading the view from its nib.
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
