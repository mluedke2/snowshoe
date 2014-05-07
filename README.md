iOS wrapper for SnowShoe
========================

The [SnowShoe Stamp](http://www.snowshoestamp.com) is a 3D-printed authentication tool for smartphones. 

![](https://beta.snowshoestamp.com/static/api/img/stamp.gif)

Installation with CocoaPods
===========================

[CocoaPods](http://cocoapods.org/) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries like SnowShoe in your projects. See the [CocoaPods guides](http://guides.cocoapods.org/using/index.html) if this is your first time using it.

#### Podfile

```ruby
platform :ios, '7.0'
pod "snowshoe", "~> 1.11"
```

* Alternatively, you can copy the files from the `SnowShoe` directory into your project. If you do that, be sure to also download and include the files from the [gtm-oauth](https://code.google.com/p/gtm-oauth/) project. This dependency is automatically handled if you go the CocoaPods route.

Usage
=====

Once you have included the dependency, there are 3 steps to use SnowShoe:

1. Subclass `SnowShoeViewController`

2. Supply an `appKey` and `appSecret`

3. Handle the Stamp Result in `stampResultDidChange`

All of these are done in the `Simple Example` project provided.

1. Subclass SnowShoeViewController
----------------------------------

Import `SnowShoeViewController.h` in a header file for a View Controller:

```objective-c
#import "SnowShoeViewController.h"
```

And subclass `SnowShoeViewController` instead of `UIViewController`:

```objective-c
@interface StampViewController : SnowShoeViewController
```

In the example project provided, this is done in [StampViewController.h](https://github.com/mluedke2/snowshoe/blob/master/SimpleExample/StampViewController.h).

2. Supply an appKey and appSecret
---------------------------------

You can obtain these by registering your app on [the SnowShoe site](http://www.snowshoestamp.com).

You can set them at any time. In the example project, this is done in [AppDelegate.m](https://github.com/mluedke2/snowshoe/blob/master/SimpleExample/AppDelegate.m).

You could alternatively use `viewDidLoad`:

```objective-c
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.appKey = @"your_app_key";
    self.appSecret = @"your_app_secret";
}
```

3. Handle the Stamp Result in stampResultDidChange
--------------------------------------------------

`stampResultDidChange` will be called anytime new knowledge about the stamp is found. It will provide an NSString, either showing that the process is waiting or a JSON response from the server.

The provided example [StampViewController.m](https://github.com/mluedke2/snowshoe/blob/master/SimpleExample/StampViewController.m) shows how to use the `waiting` constant with a `UIActivityIndicator`, and how to parse the JSON response from the server.

An example success response:

>{"stamp": {"serial": "DEV-STAMP"}, "receipt": "EdKr/rBblHx8ce+9QPZXlyVYvl4=",
> "secure": false, "created": "2013-06-19 01:08:38.366249"}

An example failure response:

>{"receipt": "iTpXGev3ya2k4UMgO7bc+9o/+mU=", "created": "2013-06-19 01:12:23.481493",
> "secure": false, "error": {"message": "Stamp not found", "code": 32}}

Questions?
==========

For hardware or API questions/feedback, address those to [SnowShoe](http://www.snowshoestamp.com) directly. For questions/feedback on this library, please file issues or pull requests. Or email me at matt@mattluedke.com, visit [my blog](http://www.mattluedke.com), or [follow me on Twitter](https://twitter.com/matt_luedke)
