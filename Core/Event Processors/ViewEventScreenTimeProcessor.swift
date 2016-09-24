// Copyright (c) 2016 Vectorform LLC
// http://www.vectorform.com/
// http://github.com/vectorform/symbiote
//
//  Symbiote/Core
//  ViewEventScreenTimeProcessor.swift
//

open class ViewEventScreenTimeProcessor: EventProcessor {
    open static let DataTag = Event.DataDescriptor("ScreenTime")!
    
    fileprivate var timingTable: Dictionary<String, Date> = [:]
    public init() {
    }
    open func process(event: inout Event) -> Bool {
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
                    event.data[ViewEventScreenTimeProcessor.DataTag] = String(event.date.timeIntervalSince(showDate))
                    timingTable.removeValue(forKey: viewName)
                }
            }
            break
        default:
            break
        }
        return true
    }
    open func defaultFilter() -> EventFilter {
        return SimpleGenericFilter(filterSenders: [Event.Senders.View])
    }

}
