// Copyright (c) 2016 Vectorform LLC
// http://www.vectorform.com/
// http://github.com/vectorform/symbiote
//
//  Symbiote/Core
//  ProhibitAllProcessor.swift
//

public class ProhibitAllProcessor: EventProcessor {
    public var allowAll: Bool
    public init(allowAll: Bool = false){
        self.allowAll = allowAll
    }
    public func processEvent(inout event: Event) -> Bool {
        return allowAll;
    }
    public func defaultFilter() -> EventFilter {
        return BooleanFilter()
    }

}
