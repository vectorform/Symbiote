// Copyright (c) 2016 Vectorform LLC
// http://www.vectorform.com/
// http://github.com/vectorform/symbiote
//
//  Symbiote/Core
//  AnalyticsEnabledNavigationController.swift
//
import UIKit

open class AnalyticsEnabledNavigationController: UINavigationController, AnalyticsCompatible {

    open var analyticsDescription: String?
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Symbiote.SharedInstance.log(event: Event(method: Event.Methods.SubclassHook, sender: Event.Senders.View, action: Event.Actions.Appear, data: [Event.DataDescriptors.ViewName: analyticsDescription ?? defaultAnalyticsDescription(), Event.DataDescriptors.Path: getViewPath()], senderObject: self))
    }
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Symbiote.SharedInstance.log(event: Event(method: Event.Methods.SubclassHook, sender: Event.Senders.View, action: Event.Actions.Disappear, data: [Event.DataDescriptors.ViewName: analyticsDescription ?? defaultAnalyticsDescription(), Event.DataDescriptors.Path: getViewPath()], senderObject: self))
    }
}
