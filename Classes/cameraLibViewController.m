//
//  cameraLibViewController.m
//  CameraLib
//
//  Created by Alexander Seville on 6/6/14.
//  Copyright (c) 2014 AlexSeville. All rights reserved.
//

#import "cameraLibViewController.h"
#import "cameraLib.h"
#import "assetLib.h"
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface cameraLibViewController ()
@property (nonatomic, strong) cameraLib *cameraLibrary;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *liveDisplayView;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *mostRecentThumnailView;
- (IBAction)tapMostRecentThumnail:(UITapGestureRecognizer *)sender;

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
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible: NO];
	[[UIApplication sharedApplication] setStatusBarHidden:YES];
    // Do any additional setup after loading the view from its nib.
	
	//load the thumbnail
	assetLib *assets = [[assetLib alloc] init];
	[assets getLatestImageWithSuccess:^(UIImage *image) {
		self.mostRecentThumnailView.image = image;
	}];
	
	//load the camera
	self.cameraLibrary = [[cameraLib alloc] init];
	NSLog(@"Set up view controller");
	[self.cameraLibrary showCameraWithPreviewView:self.liveDisplayView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (IBAction)tapMostRecentThumnail:(UITapGestureRecognizer *)sender {
	NSLog(@"in tap");
	//using the default picker just to show the behaviour
	//but ultimately this will need to be written by scratch I think
	if ([UIImagePickerController isSourceTypeAvailable:
		 UIImagePickerControllerSourceTypeSavedPhotosAlbum])
	{
		UIImagePickerController *imagePicker =
		[[UIImagePickerController alloc] init];
		//imagePicker.delegate = self;
		imagePicker.sourceType =
		UIImagePickerControllerSourceTypePhotoLibrary;
		imagePicker.allowsEditing = NO;
		
		[self presentViewController:imagePicker
						   animated:YES completion:nil];
	}
	
}
@end
