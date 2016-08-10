# Symbiote
Created and maintained by Vectorform.

[![Version](https://img.shields.io/cocoapods/v/Symbiote.svg?style=flat)](http://cocoapods.org/pods/Symbiote)
[![License](https://img.shields.io/cocoapods/l/Symbiote.svg?style=flat)](http://cocoapods.org/pods/Symbiote)
[![Platform](https://img.shields.io/cocoapods/p/Symbiote.svg?style=flat)](http://cocoapods.org/pods/Symbiote)

## About
Symbiote is an analytics framework that supports multiple platforms, auto enables basic analytics in your app and is easily extensible with event processors.
Extended analytics support can be enabled by subclassing UIButtons and UIViewControllers from analytics subclasses and providing a view name. This will enable the framework to automatically build view paths and label buttons with their respective actions correctly.
Unsupported analytics platforms may be integrated by implementing a simple event logging protocol. Custom events can be created easily.
Events may be filtered and processed (add/edit/remove/analyze data) by adding custom event processors which are filtered by EventFilters to the event bus.

### Currently Supported Platforms
  * Amazon AWS Mobile Analytics (*)
  * Answers Analytics
  * Flurry
  * Google Analytics (*)
  * Mixpanel (*)
  * Simple Logging *(Debug only!)*

*: setup requires [additional steps]()

## Installing

### Cocoapods

You can install this library using [Cocoapods](https://cocoapods.org/pods/TODO). You can get started with Cocoapods by [following their install guide](https://guides.cocoapods.org/using/getting-started.html#getting-started), and learn how to use Cocoapods to install dependencies [by following this guide](https://guides.cocoapods.org/using/using-cocoapods.html).

In your podfile, you want to add `pod 'Symbiote', '0.1.0'`. Then run `pod install` inside your terminal. With Cocoapods, we support iOS: 8.0 and above.


### Reference Documentation

You can find the latest reference documentation on [Cocoadocs](http://cocoadocs.org/docsets/Symbiote). Install this documentation to [Dash](http://kapeli.com/dash) or Xcode using [Docs for Xcode](https://documancer.com/xcode/). On the [docs page](http://cocoadocs.org/docsets/Symbiote), click the 'share' button in the upper right.

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.


## Author

Johannes Start, jstart@vectorform.de

## License

Symbiote is available under the BSD license. See the [LICENSE](LICENSE) file for more info.

## Getting Help

If you see a bug, feel free to post an issue. Please see the [contribution guidelines](https://github.com/vectorform/symbiote/blob/master/.github/CONTRIBUTING.md) before proceeding.


## Getting Started

### Basic Auto Analytics
To get started with Symbtiote and simple auto analytics integration you will need to add **pod 'Symbiote'** to your podfile. After running **pod install** you will be able to use it in your project. Auto analytics use swizzling to integrate into all UIViewControllers and UIEvents to determine when views show, disappear or buttons are pressed.
In your AppDelegate's init you have to import Symbiote and enable a log provider:
```swift
import UIKit
import Symbiote

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    override init() {
        super.init()

        // Enable simple log provider to print all output.
        // TODO: Disable for production build!
        Symbiote.SharedInstance.registerAnalyticsProvider(DebugLogProvider());
    }

}
```

### Analytics Provider
The default Provider (**DebugLogProvider**) will simply print your analytics events for debug purposes. Don't use this provider in production.
To enable one of the supported analytics providers add the relevant subspec to your podfile: `pod 'Symbiote/Provider/AWSAnalytics'`
Following subspecs are currently available:
```ruby
pod 'Symbiote/Provider/DebugLog' # Included by default.
pod 'Symbiote/Provider/AWSMobileAnalytics'
pod 'Symbiote/Provider/FlurryAnalytics'
```

### Advanced Auto Analytics (Base Classes)
To enable advanced automatic analytics you'll need to use the provided base classes for all **UIViewControllers**, **UINavigationControllers** and **UIButtons** or implement the **AnalyticsCompatible** protocol. This will enable Symbiote to automatically create view paths and hierarchies and log them accordingly.

#### UIViewControllers
```swift
import UIKit
import Symbiote

class SampleViewController: AnalyticsEnabledViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.analyticsDescription = "SampleViewController"
    }

}
```
#### Using Analytics Enabled UINavigationControllers
```swift
import UIKit
import Symbiote

class SampleNavigationController: AnalyticsEnabledNavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.analyticsDescription = "SampleNavigationController"
        // Optionally set parentViewController
        self.parentViewController = aViewController
    }

}
```
#### Using Analytics Enabled UIButtons
```swift
let sampleEventButton:AnalyticsEnabledButton = AnalyticsEnabledButton(frame: CGRectMake(100, 200, 100, 50))
sampleEventButton.setTitle("Sample Button Event", forState: UIControlState.Normal)
sampleEventButton.parentViewController = self
sampleEventButton.analyticsDescription = "SampleEventButton"
```
For more flexibility AnalyticsEnabledButton may also be subclassed.
UIButtons can use a custom analytics events for UIControlEvents.TouchUpInside:
```swift
sampleEventButton.customEvent = Event(sender: AnalyticsExtensions.SampleSender, action: AnalyticsExtensions.SampleAction)
```

### Events
Events may be created and logged by using the **Event** class. Symbiote comes packaged with a few integrated event properties. In most cases it will make sense to create custom event Methods, senders and events since the default ones are limited to basic iOS functionality.

#### Methods
Methods define how the event was logged. This may be via *Swizzling*, a *DirectCall* or *AppDelegateCall*. When creating and sending a custom event the event Method should be **Event.Methods.DirectCall** - this is the default.
Integrated Methods:

   * Event.Methods.Generic
   * Event.Methods.SwizzleHook
   * Event.Methods.SubclassHook
   * Event.Methods.AppDelegateCall
   * Event.Methods.DirectCall

Custom Methods may be defined by creating a new Event.Method:
```swift
let AnalyticsMethodBluetoothDeviceBridge = Event.Method("BluetoothDeviceBridge")
```

#### Senders
Senders represent the class of an object that sends an event. Senders include the *AppDelegate (App)*, a *UIViewController (View)* or a *UIButton (Button)*.
Integrated Senders:

  * Event.Senders.Generic
  * Event.Senders.Button
  * Event.Senders.View
  * Event.Senders.App

Senders are created by creating a new Event.Sender:
```swift
let AnalyticsSenderMap = Event.Sender("Map") // Map components that log/send events
```

#### Actions
Actions define what action was applied to the sender. A *Button* may be **Pressed** and a *View* may **Appear**.
Integrated Actions:
  * Event.Actions.Generic
  * Event.Actions.Press
  * Event.Actions.Appear
  * Event.Actions.Disappear
  * Event.Actions.Start
  * Event.Actions.Foreground
  * Event.Actions.Background
  * Event.Actions.Active
  * Event.Actions.Resign
  * Event.Actions.Terminate

A custom action for a *AnalyticsSenderMap* could be the successful location of a user: **Located**.
Actions are defined by creating an Event.Action:
```swift
let AnalyticsActionLocated = Event.Action("Located")
```

#### Data & DataDescriptors
Events can hold additional data to keep track of important metrics. When a *View* disappears it's helpful to know how long it was on screen, so the data dictionary of the event could have a key containing this metric. To simplify and standardize these keys Symbiote uses data descriptors. When adding a custom metric to the data dictionary a default DataDescriptor must be used or a custom one must be created.
Integrated DataDescriptors:
  * Event.DataDescriptors.ViewName
  * Event.DataDescriptors.SelectorName
  * Event.DataDescriptors.Path

To create a custom DataDescriptor create an Event.DataDescriptor:
```swift
let AnalyticsDataDescriptorsLocationAccuracy = Event.DataDescriptor("LocationAccuracy")
```

#### Custom Logging Events

Event with default parameters:
```swift
Symbiote.SharedInstance.logEvent(Event(method: Event.Methods.AppDelegateCall, sender: Event.Senders.App, action: Event.Actions.Start, data: [:]))
```
Event with custom parameters:
```swift
let locationAccuracy = "10m"
Symbiote.SharedInstance.logEvent(Event(sender: AnalyticsSenderMap, action: AnalyticsActionLocated, data: [ AnalyticsDataDescriptorsLocationAccuracy: locationAccuracy ]))
```

### Event Processors & Filters
Event processors add/edit/remove data from an analytics event or prohibit logging. They are executed right before logging in the order they are added. When adding an event processor a filter must be set to define on what type of event the specific processor may be executed. To enable a processor for all Events use a filter like **AllowAllFilter**.
This is how you register an event processor with a filter:
```swift
// Sample of how to prohibit all events with a .App sender
Symbiote.SharedInstance.registerEventProcessor(ProhibitAllProcessor(), filter: SimpleGenericFilter(filterSenders: [Event.Senders.App]))
```
