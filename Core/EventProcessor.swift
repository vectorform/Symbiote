// Copyright (c) 2016 Vectorform LLC
// http://www.vectorform.com/
// http://github.com/vectorform/symbiote
//
//  Symbiote/Core
//  EventProcessor.swift
//

public protocol EventProcessor: class {
    //returns wether the event should be published or not can modify event
    func process(event: inout Event) -> Bool
    func defaultFilter() -> EventFilter
    
}
public protocol EventFilter: class {
    //returns wether the event passed the filter
    func filter(event: Event) -> Bool
}

/// This allows Symbiote to use standard contains methods on collections by comparing the references of two objects
private func ==(lhs: EventProcessor, rhs: EventProcessor) -> Bool {
    return lhs === rhs
}
/// This allows Symbiote to use standard contains methods on collections by comparing the references of two objects
private func ==(lhs: EventFilter, rhs: EventFilter) -> Bool {
    return lhs === rhs
}
