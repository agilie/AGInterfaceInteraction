# AGInterfaceInteraction

[![CI Status](http://img.shields.io/travis/kalamaznik/AGInterfaceInteraction.svg?style=flat)](https://travis-ci.org/kalamaznik/AGInterfaceInteraction)
[![Version](https://img.shields.io/cocoapods/v/AGInterfaceInteraction.svg?style=flat)](http://cocoapods.org/pods/AGInterfaceInteraction)
[![License](https://img.shields.io/cocoapods/l/AGInterfaceInteraction.svg?style=flat)](http://cocoapods.org/pods/AGInterfaceInteraction)
[![Platform](https://img.shields.io/cocoapods/p/AGInterfaceInteraction.svg?style=flat)](http://cocoapods.org/pods/AGInterfaceInteraction)

### StartGravity:

<img src="https://cloud.githubusercontent.com/assets/4165054/26112030/7154b75a-3a5f-11e7-903a-af47b80318af.gif" alt="Everything" height="410" width="250" border ="50">   <img src="https://cloud.githubusercontent.com/assets/4165054/26115830/d1c64b4e-3a69-11e7-97ad-bf1fcbafd8ff.gif" alt="Boundaries" height="410" width="250" border ="50">

[Agilie Team](https://agilie.com/en/ios-development-services) would like to offer you our new
lightweight open-source library called AGInterfaceInteraction.

Our library with the new interesting animation: capturing any interface (screen or view) and
throws its UI elements over under the influence of gravity, so that one can move them from side
to side obliquely. By default, the animation lasts for about 3-4 seconds, but you can adjust
its duration at your discretion. After the animation has been completed, all the UI elements returns to their original location.

(Note: We are working with native UI elements (UILabel, UIButton, UIImageView, UISwitch,
UISlider, UITExtField, UIProgressView, UITableView/UICollectionView). If listed UI elements
embedded in UIView or UIScrollView, library picks it up and animates it separately. We keep on
working to handle most intricate interface.)

This animations can be easily used during the development of any application as an event activated after a specified user action.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.


## Usage

StartGravity:

After we choose a way to initiate animation, just provide view and duration as parameters call the method startGravityView(view: duration: collisionMode:)

````swift

@IBAction startButtonDidTouch(_ sender: Any) {
self.agGravityService.startGravityView(view: self.view, duration: 10, collisionMode: .everything)
}

````

## Installation

AGInterfaceInteraction is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "AGInterfaceInteraction"
```

## Author

This library is open-sourced by [Agilie Team](https://www.agilie.com) info@agilie.com

## Contributors

[Michael Liptuga](https://github.com/Liptuga-Michael) - <michael.liptuga@agilie.com>


## Contact us

<ios@agilie.com>

## License

The [MIT](LICENSE.MD) License (MIT) Copyright © 2017 [Agilie Team](https://www.agilie.com)
