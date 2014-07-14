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
#import <DDExpandableButton.h>

NSString *const ASCameraViewPickerControllerMediaType = @"ASCameraViewPickerControllerMediaType";
NSString *const ASCameraViewPickerControllerOriginalImage = @"ASCameraViewPickerControllerOriginalImage";
NSString *const ASCameraViewPickerControllerEditedImage = @"ASCameraViewPickerControllerEditedImage";
NSString *const ASCameraViewPickerControllerCropRect = @"ASCameraViewPickerControllerCropRect";
NSString *const ASCameraViewPickerControllerMediaURL = @"ASCameraViewPickerControllerMediaURL";
NSString *const ASCameraViewPickerControllerReferenceURL = @"ASCameraViewPickerControllerReferenceURL";
NSString *const ASCameraViewPickerControllerMediaMetadata = @"ASCameraViewPickerControllerMediaMetadata";

@interface ASCameraViewPickerController ()

- (IBAction)onCancelButtonClick:(id)sender;
- (IBAction)onTapCapture:(UITapGestureRecognizer *)sender;
- (IBAction)onTapCameraToggle:(UITapGestureRecognizer *)sender;
@property (unsafe_unretained, nonatomic) IBOutlet ASCameraView *cameraView;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *toggleDeviceView;
@property (nonatomic, strong) DDExpandableButton *flashButton;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *captureView;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *cancelButton;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *useButton;
- (IBAction)onTapUse:(id)sender;
@property (strong, nonatomic) UIImage *capturedImage;

@end

@implementation ASCameraViewPickerController

bool hasTaken = false;

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
	
	NSArray *buttons = [NSArray arrayWithObjects:@"Auto", @"On", @"Off", nil];
	self.flashButton = [[DDExpandableButton alloc] initWithPoint:CGPointMake(0, 0) leftTitle:[UIImage imageNamed:@"flash.png"] buttons:buttons];
	self.flashButton.borderColor = [UIColor blackColor];
	self.flashButton.textColor = [UIColor whiteColor];
	self.flashButton.backgroundColor = [UIColor blackColor];
	self.flashButton.selectedItem = 0;
	
	[self.view addSubview:self.flashButton];
	[self.flashButton addTarget:self action:@selector(toggleFlash:) forControlEvents:UIControlEventValueChanged];
	if (![self.cameraView enableDeviceSwitching]){
		self.toggleDeviceView.alpha = 0.7;
		self.toggleDeviceView.userInteractionEnabled = false;
	}
	
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (IBAction)onCancelButtonClick:(id)sender {
	if (!hasTaken){
		[self dismissViewControllerAnimated:YES completion:nil];
		if (self.delegate && [self.delegate respondsToSelector:@selector(imagePickerControllerDidCancel:)]) {
			[self.delegate imagePickerControllerDidCancel:self];
		}
	} else {
		[self.cameraView restartCamera];
		[self showCaptureUI];
	}
}

- (IBAction)onTapCapture:(UITapGestureRecognizer *)sender {
	[self.cameraView recordWithCompletion:^(UIImage *mostRecent) {
		[self hideCaptureUI];
		self.capturedImage = mostRecent;
	}];
}

- (void) hideCaptureUI {
	hasTaken = true;
	[self.toggleDeviceView setHidden:YES];
	[self.flashButton setHidden:YES];
	[self.captureView setHidden:YES];
	self.cancelButton.titleLabel.text = @"Retake";
	[self.useButton setHidden:NO];
}

- (void) showCaptureUI {
	hasTaken = false;
	[self.toggleDeviceView setHidden:NO];
	[self.flashButton setHidden:NO];
	[self.captureView setHidden:NO];
	[self.cancelButton setHidden:NO];
	self.cancelButton.titleLabel.text = @"Cancel";
	[self.useButton setHidden:YES];
}

- (IBAction)onTapCameraToggle:(UITapGestureRecognizer *)sender {
	NSLog(@"clicked camera");
	[self.cameraView changeCamera];
	
}

- (void) toggleFlash:(DDExpandableButton *)sender
{
	switch ([sender selectedItem])
	{
		default:
			[self.cameraView setFlashMode:0];
			break;
		case 1:
			[self.cameraView setFlashMode:1];
			break;
		case 2:
			[self.cameraView setFlashMode:2];
			break;
	}
}

- (IBAction)onTapUse:(id)sender {
	//save
	//also weird visual effect here?
	[self dismissViewControllerAnimated:YES completion:nil];
	if (self.delegate && [self.delegate respondsToSelector:@selector(imagePickerController:didFinishPickingMediaWithInfo:)]) {
		[self.delegate imagePickerController:self didFinishPickingMediaWithInfo:@{
		ASCameraViewPickerControllerOriginalImage:  self.capturedImage
		}];
	}
}
@end
