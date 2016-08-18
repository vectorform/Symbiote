// Copyright (c) 2016 Vectorform LLC
// http://www.vectorform.com/
// http://github.com/vectorform/symbiote
//
//  Symbiote/Core
//  AnalyticsEnabledButton.swift
//
import UIKit

public class AnalyticsEnabledButton: UIButton, AnalyticsCompatible {

    public var analyticsDescription: String = String(self.dynamicType.self)
    public weak var parentViewController: UIViewController?
    public var customEvent: Event?
    
    public func buttonPressed(sender: AnyObject) {
        if let customEvent = customEvent {
            Symbiote.SharedInstance.logEvent(customEvent)
            // nothing else to do here
            return
        }
        let event = Event(method: Event.Methods.SubclassHook)
        if sender is UIButton {
            event.sender = Event.Senders.Button;
            event.action = Event.Actions.Press;
        }
        event.data[Event.DataDescriptors.ViewName] = analyticsDescription
        event.data[Event.DataDescriptors.ControlEvent] = "TouchUpInside"
        event.data[Event.DataDescriptors.Path] = getViewPath()
        event.senderObject = self
        
        Symbiote.SharedInstance.logEvent(event)
    }
    override public init(frame: CGRect) {
        super.init(frame: frame)
        addTarget(self, action: #selector(buttonPressed), forControlEvents: UIControlEvents.TouchUpInside)
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addTarget(self, action: #selector(buttonPressed), forControlEvents: UIControlEvents.TouchUpInside)

    }

}
