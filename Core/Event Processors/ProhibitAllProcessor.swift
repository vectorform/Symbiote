// Copyright (c) 2016 Vectorform LLC
// http://www.vectorform.com/
// http://github.com/vectorform/symbiote
//
//  Symbiote/Core
//  ProhibitAllProcessor.swift
//

open class ProhibitAllProcessor: EventProcessor {
    open var allowAll: Bool
    public init(allowAll: Bool = false){
        self.allowAll = allowAll
    }
    open func process(event: inout Event) -> Bool {
        return allowAll
    }
    open func defaultFilter() -> EventFilter {
        return BooleanFilter()
    }

}
