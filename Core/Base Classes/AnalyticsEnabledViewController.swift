// Copyright (c) 2016 Vectorform LLC
// http://www.vectorform.com/
// http://github.com/vectorform/symbiote
//
//  Symbiote/Core
//  AnalyticsEnabledViewController.swift
//

import UIKit


public class AnalyticsEnabledViewController: UIViewController, AnalyticsCompatible {
    
    public var analyticsDescription: String?
    
    override public func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        Symbiote.SharedInstance.logEvent(Event(method: Event.Methods.SubclassHook, sender: Event.Senders.View, action: Event.Actions.Appear, data: [Event.DataDescriptors.ViewName: analyticsDescription ?? defaultAnalyticsDescription(), Event.DataDescriptors.Path: getViewPath()], senderObject: self))
    }
    override public func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        Symbiote.SharedInstance.logEvent(Event(method: Event.Methods.SubclassHook, sender: Event.Senders.View, action: Event.Actions.Disappear, data: [Event.DataDescriptors.ViewName: analyticsDescription ?? defaultAnalyticsDescription(), Event.DataDescriptors.Path: getViewPath()], senderObject: self))
    }
    
}
