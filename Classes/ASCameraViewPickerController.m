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

@interface ASCameraViewPickerController ()

- (IBAction)onCancelButtonClick:(id)sender;
- (IBAction)onTapCapture:(UITapGestureRecognizer *)sender;
@property (unsafe_unretained, nonatomic) IBOutlet ASCameraView *cameraView;

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
	
	NSArray *buttons = [NSArray arrayWithObjects:@"Auto", @"On", @"Off", nil];
	DDExpandableButton *flashButton = [[DDExpandableButton alloc] initWithPoint:CGPointMake(0, 0) leftTitle:[UIImage imageNamed:@"flash.png"] buttons:buttons];
	flashButton.borderColor = [UIColor blackColor];
	flashButton.textColor = [UIColor whiteColor];
	flashButton.backgroundColor = [UIColor blackColor];
	flashButton.selectedItem = 0;
	
	[self.view addSubview:flashButton];
	[flashButton addTarget:self action:@selector(toggleFlash:) forControlEvents:UIControlEventValueChanged];
	
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
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onTapCapture:(UITapGestureRecognizer *)sender {
	[self.cameraView recordWithCompletion:^(UIImage *mostRecent) {
		NSLog(@"done!");
	}];
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

@end
