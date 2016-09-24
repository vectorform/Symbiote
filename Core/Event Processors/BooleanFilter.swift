// Copyright (c) 2016 Vectorform LLC
// http://www.vectorform.com/
// http://github.com/vectorform/symbiote
//
//  Symbiote/Core
//  AllowAllFilter.swift
//


open class BooleanFilter: EventFilter {
    
    open var allowAll: Bool
    
    /// default behaviour is to allow all
    public init(allowAll: Bool = true) {
        self.allowAll = allowAll
    }
    
    open func filter(event: Event) -> Bool {
        return allowAll
    }
}
