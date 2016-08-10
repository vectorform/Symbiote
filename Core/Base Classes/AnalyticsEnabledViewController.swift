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
    
    public func getViewPath() -> String {
        guard let parentObject = parentViewController else {
            return "/" + (analyticsDescription ?? description)
        }
        
        if let parent = parentObject as? AnalyticsCompatible {
            return parent.getViewPath() + "/" + (analyticsDescription ?? description)
        } else {
            return parentObject.description + "/" + (analyticsDescription ?? description)
        }
    }
    
    override public func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        Symbiote.SharedInstance.logEvent(Event(method: Event.Methods.SubclassHook, sender: Event.Senders.View, action: Event.Actions.Appear, data: [Event.DataDescriptors.ViewName: analyticsDescription ?? description, Event.DataDescriptors.Path: getViewPath()], senderObject: self))
    }
    override public func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        Symbiote.SharedInstance.logEvent(Event(method: Event.Methods.SubclassHook, sender: Event.Senders.View, action: Event.Actions.Disappear, data: [Event.DataDescriptors.ViewName: analyticsDescription ?? description, Event.DataDescriptors.Path: getViewPath()], senderObject: self))
    }
    
}
