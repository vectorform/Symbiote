// Copyright (c) 2016 Vectorform LLC
// http://www.vectorform.com/
// http://github.com/vectorform/symbiote
//
//  Symbiote/Example
//  AppDelegate.swift
//

import UIKit
import Symbiote

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    override init() {
        super.init()
        
        // Enable simple log provider to print all output.
        // TODO: Disable for production build!
        Symbiote.SharedInstance.register(analyticsProvider: DebugLogProvider())
        
        // Sample of how to prohibit all events with a .App sender
        Symbiote.SharedInstance.register(eventProcessor: ProhibitAllProcessor(), filter: SimpleGenericFilter(filterSenders: [Event.Senders.App]))
        
        // Sample of how to add a custom filter to Symbiote
        Symbiote.SharedInstance.register(eventProcessor: ProhibitAllProcessor(), filter: AnalyticsExtensions.AlertViewFilter())
        
        
        Symbiote.SharedInstance.log(event: Event(method: Event.Methods.AppDelegateCall, sender: Event.Senders.App, action: Event.Actions.Start, data: [:]))
        
        // Logging sample action
        Symbiote.SharedInstance.log(event: Event(method: Event.Methods.AppDelegateCall, sender: Event.Senders.App, action: AnalyticsSampleAction, data: [:]))
    }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        Symbiote.SharedInstance.log(event: Event(method: Event.Methods.AppDelegateCall, sender: Event.Senders.App, action: Event.Actions.Resign, data: [:]))

    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared reMethods, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        Symbiote.SharedInstance.log(event: Event(method: Event.Methods.AppDelegateCall, sender: Event.Senders.App, action: Event.Actions.Background, data: [:]))

    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        Symbiote.SharedInstance.log(event: Event(method: Event.Methods.AppDelegateCall, sender: Event.Senders.App, action: Event.Actions.Foreground, data: [:]))

    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        Symbiote.SharedInstance.log(event: Event(method: Event.Methods.AppDelegateCall, sender: Event.Senders.App, action: Event.Actions.Active, data: [:]))

    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        Symbiote.SharedInstance.log(event: Event(method: Event.Methods.AppDelegateCall, sender: Event.Senders.App, action: Event.Actions.Terminate, data: [:]))

    }


}

