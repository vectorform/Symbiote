// Copyright (c) 2016 Vectorform LLC
// http://www.vectorform.com/
// http://github.com/vectorform/symbiote
//
//  Symbiote/Core
//  Event.swift
//

/**
    # Event
    The Event class contains all information about an event that should be logged. It comes with some subclasses that define communly used Event Methods, Senders, Actions and DataDescriptors.

*/
public class Event {
    /**
        Descriptor is the base class for Method, Sender, Action and DataDescriptor.
     */
    
    public typealias Descriptor = String
    public typealias Method = Descriptor
    public typealias Sender = Descriptor
    public typealias Action = Descriptor
    public typealias DataDescriptor = Descriptor

    public struct Methods {
        // Passed by generic, non-defined method
        public static let Generic = Method("Generic")
        // Passed by swizzle hook
        public static let SwizzleHook = Method("Swizzle")
        // Passed by subclass/base class
        public static let SubclassHook = Method("Subclass")
        // Passed in the AppDelegate
        public static let AppDelegateCall = Method("AppDelegate")
        // Passed directly
        public static let DirectCall = Method("Direct")
        
    }
    public struct Senders {
        // Generic, not defined sender
        public static let Generic = Sender("Generic")
         // UIControl
        public static let Control = Sender("Control")
        // UIButton
        public static let Button = Sender("Button")
        // UIView(Controller)
        public static let View = Sender("View")
        // AppDelegate
        public static let App = Sender("App")
        
    }
    
    public struct Actions {
        public static let Generic = Action("Generic")
        
        // UIControl SendAction
        public static let TargetSelector = Action("TargetSelector")
        
        
        // Button
        public static let Press = Action("Press")
        
        // View
        public static let Appear = Action("Appear")
        public static let Disappear = Action("Disappear")
        
        // App
        public static let Start = Action("Start")
        public static let Foreground = Action("Foreground")
        public static let Background = Action("Background")
        public static let Active = Action("Active")
        public static let Resign = Action("Resign")
        public static let Terminate = Action("Terminate")
        
    }
    public struct DataDescriptors {
        public static let ViewName = DataDescriptor("ViewName")
        public static let SelectorName = DataDescriptor("SelectorName")
        public static let ControlEvent = DataDescriptor("ControlEvent")
        public static let Path = DataDescriptor("Path")
    }

    public weak var senderObject: AnyObject?
    
    public var method: Method = Methods.Generic
    public var sender: Sender = Senders.Generic
    public var action: Action = Actions.Generic
    public var date: NSDate = NSDate()
    public var data: Dictionary<DataDescriptor, String> = Dictionary()
    
    public init(method: Method = Event.Methods.DirectCall, sender: Sender = Event.Senders.Generic, action: Action = Event.Actions.Generic, data: Dictionary<DataDescriptor, String> = [:], senderObject: AnyObject?) {
        self.method = method
        self.sender = sender
        self.action = action
        self.data = data
        self.senderObject = senderObject
    }
    public convenience init(method: Method = Event.Methods.DirectCall, sender: Sender = Event.Senders.Generic, action: Action = Event.Actions.Generic, data: Dictionary<DataDescriptor, String> = [:]) {
        self.init(method: method, sender: sender, action: action, data: data, senderObject: nil)
    }
    public func log(){
        Symbiote.SharedInstance.logEvent(self)
    }
}