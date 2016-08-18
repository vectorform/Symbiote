// Copyright (c) 2016 Vectorform LLC
// http://www.vectorform.com/
// http://github.com/vectorform/symbiote
//
//  Symbiote/Core
//  AnalyticsEnabledNavigationController.swift
//
import UIKit

public class AnalyticsEnabledNavigationController: UINavigationController, AnalyticsCompatible {

    public var analyticsDescription: String = String(self.dynamicType.self)
    
    override public func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        Symbiote.SharedInstance.logEvent(Event(method: Event.Methods.SubclassHook, sender: Event.Senders.View, action: Event.Actions.Appear, data: [Event.DataDescriptors.ViewName: analyticsDescription, Event.DataDescriptors.Path: getViewPath()], senderObject: self))
    }
    override public func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        Symbiote.SharedInstance.logEvent(Event(method: Event.Methods.SubclassHook, sender: Event.Senders.View, action: Event.Actions.Disappear, data: [Event.DataDescriptors.ViewName: analyticsDescription, Event.DataDescriptors.Path: getViewPath()], senderObject: self))
    }
}
