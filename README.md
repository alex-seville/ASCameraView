cameraLib (real name TBD)
=========

##Try it out

1. Clone this repo
2. Create an empty xcode project in a different directory
3. Add a Podfile to your new project with `pod "cameraLib", :path => "../cameraLib/"` (where '../' is the appropriate path to the cloned repo)
4. Run `pod install`
5. Open your test workspace and add `#import <cameraLibViewController.h>` to the top of a file
6. In a viewLoad or action, add `cameraLibViewController *picker = [[cameraLibViewController alloc] init];` to init the library viewcontroller
7. Add `[self presentViewController:picker animated:YES completion:nil];` to present the view controller

##Structure

The current plan is to have the library act like UIImagePickerController, except with a more advanced featureset.

##Features

A camera lib for iOS

Some features to implement (not a prioritized list, just brainstorming):

- flash

 - [ ] allow toggling of modes
 
 - [ ] allow customization of UI via delegate
 
- HDR

 - [ ] allow toggling of HDR
 
 - [ ] allow customization of bracketing (maybe only available in ios8)
 
 - [ ] allow customization of UI via delegate

- Device switching

 - [ ] toggling between front and back camera
 
 - [ ] customization of UI via delegate

- focus rectangle

 - [x] show focus rectangle on autofocus changes (iOS 6 or less style)
 
 - [ ] show focus rectangle on autofocus changes (iOS 7+ style)
 
 - [x] tap to focus
 
 - [ ] show smaller focus rectangle when tapped focus change is made
 
 - [ ] customize focus color
 
 - [x] allow custom focus icon
 
 - [ ] expose focus overlay display to a delegate

- digital zoom

 - [ ] pinch to zoom in or out digitally
 
 - [ ] customize colors
 
 - [ ] customization of ui via delegate

- [ ] default crops (photo, square)

- [ ] mode toggle (video, photo, square, pano)

- camera roll thumbnail

 - [x] camera roll preview thumbnail

 - [ ] customize album for preview/saving

 - [ ] camera roll browser (after clicking on thumbnail

- [ ] basic effects

- [ ] live effect preview

- video 

 - [ ] take pictures while video is recording

 - [ ] show video run time

- pano

 - [ ] show stability arrow

 - [ ]  allow long shutter photo taking

- [ ] customize shutter button

- [x] customize background color



Some neat third-party features include:

- [ ] Holding down to record videos vine-style (stop motion/starting and stopping)

- [x] ~~using both cameras simultaenously~~ (not possible according to Apple)

- [ ] adding custom overlays to the image (i.e. seene)


----------

Taking inspiration from:
- https://github.com/danielebogo/DBCamera (custom camera)
- https://github.com/AFNetworking/AFNetworking (popular, reliable library)
- http://guides.cocoapods.org/making/making-a-cocoapod.html (creating a cocoapod)
- http://blog.sigmapoint.pl/developing-static-library-for-ios-with-cocoapods/
  
Resources:
- https://developer.apple.com/library/ios/documentation/AudioVideo/Conceptual/AVFoundationPG/Articles/04_MediaCapture.html
- http://www.ios-developer.net/iphone-ipad-programmer/development/camera/record-video-with-avcapturesession-2
