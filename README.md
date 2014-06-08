cameraLib (real name TBD)
=========

##Structure

The current plan is to have the library act like UIImagePickerController, except with a more advanced featureset.

##Features

A camera lib for iOS

Some features to implement (not a prioritized list, just brainstorming):

- [ ] flash - on off auto toggle and functionality
 
- [ ] HDR on/off toggle (and maybe specifying the bracketing?)

- [ ] front/back camera toggle

- [ ] focus rectangle (color, functionality)

- [ ] pinch digital zoom

- [ ] default crops (photo, square)

- [ ] mode toggle (video, photo, square, pano)

- [x] camera roll preview thumbnail

- [ ] live effect preview

- video 

 - [ ] take pictures while video is recording

 - [ ] show video run time

- pano

 - [ ] show stability arrow

 - [ ]  allow long shutter photo taking

- [ ] customize buttons

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
