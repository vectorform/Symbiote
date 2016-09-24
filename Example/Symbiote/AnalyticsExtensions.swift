// Copyright (c) 2016 Vectorform LLC
// http://www.vectorform.com/
// http://github.com/vectorform/symbiote
//
//  Symbiote/Example
//  AnalyticsExtension.swift
//

import UIKit
import Symbiote

// Option one:
struct AnalyticsExtensions {
    static let SampleMethod = Event.Method("SampleMethod")!

    static let SampleSender = Event.Sender("SampleSender")!
    
    static let SampleAction = Event.Action("SampleAction")!

    static let SampleDataDescriptor = Event.DataDescriptor("SampleDataDescriptor")!
    
    
    class AlertViewFilter: EventFilter {
        func filter(event: Event) -> Bool {
            if let senderObject = event.senderObject {
                if senderObject is UIAlertController {
                    return true
                }
            }
            // disable UIInputWindowController
            
            if let viewName = event.data[Event.DataDescriptors.ViewName] {
                if viewName.contains("UIInputWindowController") || viewName.contains("UIApplicationRotationFollowingController") {
                    return true
                }
            }
            return false
        }
    }
}

// Option two:
let AnalyticsSampleMethod = Event.Method("SampleMethod")!
let AnalyticsSampleSender = Event.Sender("SampleSender")!
let AnalyticsSampleAction = Event.Action("SampleAction")!
let AnalyticsSampleDataDescriptor = Event.DataDescriptor("SampleDataDescriptor")!


