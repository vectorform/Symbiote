// Copyright (c) 2016 Vectorform LLC
// http://www.vectorform.com/
// http://github.com/vectorform/symbiote/symbiote
//
//  Symbiote/Core
//  UIApplication+Hook.swift
//

import UIKit

extension UIApplication: SwizzleCompatible {
    internal static let SwizzleMethods = [
        #selector(UIApplication.sendAction(_:to:from:for:)): Selector("SYMBIOTE_sendAction_SW:to:from:forEvent:"),
    ]
    
    internal func SYMBIOTE_sendAction_SW(_ action: Selector, to target: AnyObject, from: AnyObject, forEvent: UIEvent) {
        // we don't want to use swizzled method on analytics compatible class. logging is handled already
        if !(from is AnalyticsCompatible) {
            if from is UIControl {
                Symbiote.SharedInstance.log(event: 
                    Event(
                        method: Event.Methods.SwizzleHook,
                        sender: from is UIButton ? Event.Senders.Button : Event.Senders.Control,
                        action: Event.Actions.TargetSelector,
                        data: [
                            Event.DataDescriptors.SelectorName: NSStringFromSelector(action),
                            Event.DataDescriptors.ViewName: String(describing: type(of: from).self)
                        ],
                        senderObject: from
                    )
                )
            }
        }
        
        SYMBIOTE_sendAction_SW(action, to: target, from: from, forEvent: forEvent)

    }

}
