iOS wrapper for SnowShoe SDK v2
===============================

This repo contains an example project using the [SnowShoe Stamp](http://www.snowshoestamp.com). You can:

* Download the example project to see how easy it is to drop in [SnowShoe](http://www.snowshoestamp.com) functionality.

-or-

* Just grab the folder labelled "SnowShoe" that contains the guts, and get it working in your own project. ([Skip down to Section 2](https://github.com/mluedke2/snowshoe#2-use-in-your-own-project))

1. Test-run the Example
-----------------------

* Download the whole repository and open up SimpleExample.xcodeproj in Xcode.

* Make sure to insert your `appKey` and `appSecret` that you get from the [SnowShoe site](http://www.snowshoestamp.com) when you register a new application (which is totally free!). In the ViewController.m file, look for the spots labelled: `your_key` and `your_secret`.

* *If you don't put in a valid key/secret pair, the SnowShoe servers will disapprove of you. Stay on their good side and feed them a key and secret!*

* Run your project on a touchscreen device, and select View > Debug Area > Activate Console. As you navigate to the "stamp screen," notice that the log will get updated. Stamp your phone with your developer's stamp ([need one? they're totally free](https://beta.snowshoestamp.com/get_started/)) and you can hopefully see a result like this:

>{"stamp": {"serial": "DEV-STAMP"}, "receipt": "EdKr/rBblHx8ce+9QPZXlyVYvl4=",
> "secure": false, "created": "2013-06-19 01:08:38.366249"}

* I've gone ahead and written the beginnings of a parser that simply makes note of the serial number (if any), and logs something like the following:

>Success! Your stamp serial number is DEV-STAMP.
> You should go do something responsible with this great power.

* If you use a production (aka not the free developer) stamp that hasn't been tied to your `appKey`, or press your fingers against the phone, or whatever, you'll get a message like the following:

>{"receipt": "iTpXGev3ya2k4UMgO7bc+9o/+mU=", "created": "2013-06-19 01:12:23.481493",
> "secure": false, "error": {"message": "Stamp not found", "code": 32}}

* And my very basic parser will log out:

>The stamp didn't return any valid serials.
> You should now do something responsible with this great power,
> like tell your user to use a valid stamp or try again.

2. Use in your own Project
--------------------------

* You'll want to take everything in the "SnowShoe" folder and copy it into your own project. Make sure that all the .m files are included in your Compile Sources, and the .xib and .png files are included in your Copy Bundle Resources.

* To interact with the [SnowShoe](http://www.snowshoestamp.com) servers, one must use OAuth 1.0a. But this project uses classes from [gtm-oauth](https://code.google.com/p/gtm-oauth/) and is set up so that you don't have to worry about it!

* *Make sure to add the "-fno-objc-arc" flag to the GTM classes! Do this by clicking on your target, then Build Phases, then Compile Sources. Double click in the Compiler Flags column for those classes and add the flag. Otherwise you will get a bunch of errors for them not being ARC.*

* Mimic the functions in the sample project to present the "stamp screen," set the `appKey` and `appSecret` before making any queries, and monitor the stampResult.

* Reconfigure the .xib file to reflect the user interface you'd like on the stamp screen. I'd recommend keeping the swipe-to-go-back functionality, but using a navigation controller or other means could be fine. Just be aware of screen space and the 5-touch requirement of the stamp.

Questions?
==========

For hardware or API questions/feedback, address those to [SnowShoe](http://www.snowshoestamp.com) directly. For questions/feedback on this library, email me at mluedke2@gmail.com, visit [my blog](http://www.mattluedke.com), or [follow me on Twitter](https://twitter.com/matt_luedke)
