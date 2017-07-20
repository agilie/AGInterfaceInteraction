<p align="center">

<img src="https://user-images.githubusercontent.com/4165054/28317389-52c09c2c-6bcf-11e7-90a6-1d1e104b406d.png" alt="AGInterfaceInteraction" title="AGInterfaceInteraction" width="557"/>
</p>

<p>

</p>

<p align="center">

<a href="https://www.agilie.com?utm_source=github&utm_medium=referral&utm_campaign=Git_Swift&utm_term=AGInterfaceInteraction">
<img src="https://img.shields.io/badge/Made%20by-Agilie-green.svg?style=flat" alt="Made by Agilie">
</a>

<a href="https://travis-ci.org/kalamaznik/AGInterfaceInteraction">
<img src="http://img.shields.io/travis/agilie/AGInterfaceInteraction.svg?style=flat" alt="CI Status">
</a>

<a href="http://cocoapods.org/pods/AGInterfaceInteraction">
<img src="https://img.shields.io/cocoapods/v/AGInterfaceInteraction.svg?style=flat" alt="Version">
</a>

<a href="http://cocoapods.org/pods/AGInterfaceInteraction">
<img src="https://img.shields.io/cocoapods/l/AGInterfaceInteraction.svg?style=flat" alt="License">
</a>

<a href="http://cocoapods.org/pods/AGInterfaceInteraction">
<img src="https://img.shields.io/cocoapods/p/AGInterfaceInteraction.svg?style=flat" alt="Platform">
</a>

</p>

### StartGravity:

<img src="https://cloud.githubusercontent.com/assets/4165054/26112030/7154b75a-3a5f-11e7-903a-af47b80318af.gif" alt="Everything" height="410" width="250" border ="50">   <img src="https://cloud.githubusercontent.com/assets/4165054/26115830/d1c64b4e-3a69-11e7-97ad-bf1fcbafd8ff.gif" alt="Boundaries" height="410" width="250" border ="50">   <img src="https://user-images.githubusercontent.com/4165054/28424304-ee96ba8a-6d75-11e7-986c-fa9a1a0ac781.gif" alt="Fine intergace" height="410" width="250" border="50">

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

This library is open-sourced by [Agilie Team](https://www.agilie.com?utm_source=github&utm_medium=referral&utm_campaign=Git_Swift&utm_term=AGInterfaceInteraction) info@agilie.com

## Contributors

[Michael Liptuga](https://github.com/Liptuga-Michael) - <michael.liptuga@agilie.com>


## Contact us

<ios@agilie.com>

## License

The [MIT](LICENSE.MD) License (MIT) Copyright © 2017 [Agilie Team](https://www.agilie.com?utm_source=github&utm_medium=referral&utm_campaign=Git_Swift&utm_term=AGInterfaceInteraction)
