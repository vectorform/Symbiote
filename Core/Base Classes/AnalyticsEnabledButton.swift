// Copyright (c) 2016 Vectorform LLC
// http://www.vectorform.com/
// http://github.com/vectorform/symbiote
//
//  Symbiote/Core
//  AnalyticsEnabledButton.swift
//
import UIKit

open class AnalyticsEnabledButton: UIButton, AnalyticsCompatible {

    open var analyticsDescription: String?
    
    open weak var parentViewController: UIViewController?
    open var customEvent: Event?
    
    open func buttonPressed(_ sender: AnyObject) {
        if let customEvent = customEvent {
            Symbiote.SharedInstance.log(event: customEvent)
            // nothing else to do here
            return
        }
        let event = Event(method: Event.Methods.SubclassHook)
        if sender is UIButton {
            event.sender = Event.Senders.Button;
            event.action = Event.Actions.Press;
        }
        event.data[Event.DataDescriptors.ViewName] = analyticsDescription ?? defaultAnalyticsDescription()
        event.data[Event.DataDescriptors.ControlEvent] = "TouchUpInside"
        event.data[Event.DataDescriptors.Path] = getViewPath()
        event.senderObject = self
        
        Symbiote.SharedInstance.log(event: event)
    }
    override public init(frame: CGRect) {
        super.init(frame: frame)
        addTarget(self, action: #selector(buttonPressed), for: UIControlEvents.touchUpInside)
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addTarget(self, action: #selector(buttonPressed), for: UIControlEvents.touchUpInside)

    }

}
