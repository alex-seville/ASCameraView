ASCameraView
=========

##Try it out

1. Clone this repo
2. Create an empty xcode project in a different directory
3. Add a Podfile to your new project with `pod "ASCameraView", :path => "../ASCameraView/"` (where '../' is the appropriate path to the cloned repo)
4. Run `pod install`
5. Open your test workspace and add `#import <ASCameraViewPickerController.h>` to the top of a file
6. In a viewDidAppear (viewDidLoad won't work) or action (i.e. button click), add `ASCameraViewPickerController *picker = [[ASCameraViewPickerController alloc] init];` to init the library viewcontroller
7. Add `[self presentViewController:picker animated:YES completion:nil];` to present the view controller

##Structure

There are 3 parts:

ASCamera - the underlying AVFoundation logic

ASCameraView - a camera view using ASCamera

ASCameraViewPickerController - a drop-in replacement for UIImagePickerController

##Features

I've split the feature set into 5 milestones

- [ ] Milestone #1: Feature/API parity with UIImagePickerController

- [ ] Milestone #2: Customizations to that feature set (colors, images, etc...)

- [ ] Milestone #3: Feature/API parity with the iOS camera app

- [ ] Milestone #4: Customization to that feature set

- [ ] Milestone #5: Advanced features


###Milestone #1: Feature/API parity with UIImagePickerController

- flash

 - [ ] allow toggling of modes
 
- Device switching

 - [ ] toggling between front and back camera
 
- capture

 - [ ] take single photo
 
 - [ ] use/retake buttons

 - [ ] choose crop after taking

 - [ ] cancel button

- focus rectangle

 - [ ] show focus rectangle on autofocus changes (iOS 6 or less style)
 
 - [ ] show focus rectangle on autofocus changes (iOS 7+ style)
 
 - [ ] tap to focus
 
 - [ ] holding down capture button does a center focus
 
 - [x] show smaller focus rectangle when tapped focus change is made
 
 - [ ] set exposure on focus

- digital zoom

 - [ ] pinch to zoom in or out digitally
 
- video  

 - [ ] record video


###Milestone #2: Customizations to that feature set (colors, images, etc...)

- flash
 
  - [ ] allow customization of UI/behavior via delegate/block

- Device switching
 
 - [ ] customization of UI via delegate
 
- capture
 
 - [ ] alternate saving locations (in memory, straight to web, etc...)
 
- focus rectangle
 
 - [ ] customize focus color
 
 - [ ] allow custom focus icon
 
 - [ ] expose focus overlay display to a delegate

- digital zoom
 
 - [ ] customize colors
 
 - [ ] customization of ui via delegate
 
- [ ] customize shutter button

- [ ] customize background color
 
 
###Milestone #3: Feature/API parity with the iOS camera app
 
 
 - capture

- [ ] update thumbnail after photo taken

- [ ] allow long press on record button to take multiple

- HDR

 - [ ] allow toggling of HDR
 
- [ ] default crops (photo, square)

- [ ] mode toggle (video, photo, square, pano)

- camera roll thumbnail

 - [ ] camera roll preview thumbnail
 
 - [ ] use animation when updating thumbnail

 - [ ] camera roll browser (after clicking on thumbnail
 
- [ ] basic effects

- [ ] live effect preview
 
- video

 - [ ] take pictures while video is recording

 - [ ] show video run time
 
 - [ ] slow mo video

- pano

 - [ ] show stability arrow

 - [ ]  allow long shutter photo taking
 

###Milestone #4: Customization to that feature set


- capture

- [ ] add shutter sound
 
- HDR
 
 - [ ] allow customization of bracketing (maybe only available in ios8)
 
 - [ ] allow customization of UI/behavior via delegate/block

- focus rectangle
 
 - [ ] add sound on focus tap

- camera roll thumbnail

 - [ ] customize album for preview/saving


###Milestone #5: Advanced features


- [ ] Holding down to record videos vine-style (stop motion/starting and stopping)

- [x] ~~using both cameras simultaenously~~ (not possible according to Apple)

- [ ] adding custom overlays to the image (i.e. seene)

- [ ] timers

- [ ] multiple exposures

- [ ] multi-shots

- [ ] face detect timer

- [ ] fake lytro effect (taking images with different focus depths)



----------

Taking inspiration from:
- https://github.com/danielebogo/DBCamera (custom camera)
- https://github.com/AFNetworking/AFNetworking (popular, reliable library)
- http://guides.cocoapods.org/making/making-a-cocoapod.html (creating a cocoapod)
- http://blog.sigmapoint.pl/developing-static-library-for-ios-with-cocoapods/
  
Resources:
- https://developer.apple.com/library/ios/documentation/AudioVideo/Conceptual/AVFoundationPG/Articles/04_MediaCapture.html
- http://www.ios-developer.net/iphone-ipad-programmer/development/camera/record-video-with-avcapturesession-2
- https://developer.apple.com/library/ios/samplecode/AVCam/Listings/AVCam_AVCamViewController_m.html
