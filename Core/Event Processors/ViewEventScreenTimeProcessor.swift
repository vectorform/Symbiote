// Copyright (c) 2016 Vectorform LLC
// http://www.vectorform.com/
// http://github.com/vectorform/symbiote
//
//  Symbiote/Core
//  ViewEventScreenTimeProcessor.swift
//

public class ViewEventScreenTimeProcessor: EventProcessor {
    public static let DataTag = Event.DataDescriptor("ScreenTime")
    
    private var timingTable: Dictionary<String, NSDate> = [:]
    public init() {
    }
    public func processEvent(inout event: Event) -> Bool {
        assert(event.sender == Event.Senders.View, "ViewEventProcessor only supports views")
        
        switch event.action {
        case Event.Actions.Appear:
            if let viewName = event.data[Event.DataDescriptors.ViewName] {
                timingTable[viewName] = event.date
            }
            
            break
        case Event.Actions.Disappear:
            if let viewName = event.data[Event.DataDescriptors.ViewName] {
                if let showDate = timingTable[viewName] {
                    event.data[ViewEventScreenTimeProcessor.DataTag] = String(event.date.timeIntervalSinceDate(showDate))
                    timingTable.removeValueForKey(viewName)
                }
            }
            break
        default:
            break
        }
        return true
    }
    public func defaultFilter() -> EventFilter {
        return SimpleGenericFilter(filterSenders: [Event.Senders.View])
    }

}
