# KKDCountDown

[![CI Status](http://img.shields.io/travis/kadirkemal/KKDCountDown.svg?style=flat)](https://travis-ci.org/kadirkemal/KKDCountDown)
[![Version](https://img.shields.io/cocoapods/v/KKDCountDown.svg?style=flat)](http://cocoapods.org/pods/KKDCountDown)
[![License](https://img.shields.io/cocoapods/l/KKDCountDown.svg?style=flat)](http://cocoapods.org/pods/KKDCountDown)
[![Platform](https://img.shields.io/cocoapods/p/KKDCountDown.svg?style=flat)](http://cocoapods.org/pods/KKDCountDown)

----------
KKDCountDown is the simple circle countdown. You can easly configure the circle design. KKDCountDown uses mach_absolute_time function to measure duration accurately.
----------

## SCREENSHOT

<img src="https://raw.githubusercontent.com/KadirKemal/KKDCountDown/master/Example/kkdcountdown.gif" width="200px">

## Installation

KKDCountDown is available through [CocoaPods](http://cocoapods.org). To install it, simply add the following line to your Podfile:

```
pod 'KKDCountDown'
```

## Usage

### Parameters

#### circleWidth
It is the line width of the circle. Default value is 15.

#### circleColor
It is the color of the circle. Default value is UIColor.gray.

#### progressColor
It is the color of the circle. Default value is UIColor.red.

#### textColor
It is the color of the text. Default value is UIColor.red.

#### textFont
It is the font of the text. Default value is UIFont.systemFont(ofSize: 36)

#### defaultText
It is the default text. Default value is ""

#### textWinkingPeriod
It is the default text. This value should be between 0 and 1. Default value is 0.2

## Starting Count Down
use startCountDown function to start 
```
        circularCountDown.startCountDown(10) {
            let alert = UIAlertController(title: "Time is up", message: "", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) -> Void in })
            alert.addAction(cancel)
            self.present(alert, animated: true)
        }
```

## Stopping Count Down
use stopCountDown function to start 
```
        circularCountDown.stopCountDown();
```

## Pausing Count Down
use stopCountDown function to start 
```
        circularCountDown.pauseCountDown();
```

## Resuming Count Down
use stopCountDown function to start 
```
        circularCountDown.resumeCountDown();
```

## Accurate Measurement
KKDCountDown uses mach_absolute_time() function to measure duration accurately.


## Author

Kadir Kemal Dursun, https://github.com/KadirKemal

## License

KKDCountDown is available under the MIT license. See the LICENSE file for more info.
