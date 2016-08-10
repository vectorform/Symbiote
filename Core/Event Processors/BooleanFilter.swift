// Copyright (c) 2016 Vectorform LLC
// http://www.vectorform.com/
// http://github.com/vectorform/symbiote
//
//  Symbiote/Core
//  AllowAllFilter.swift
//


public class BooleanFilter: EventFilter {
    
    public var allowAll: Bool
    
    /// default behaviour is to allow all
    public init(allowAll: Bool = true) {
        self.allowAll = allowAll
    }
    
    public func filterEvent(event: Event) -> Bool {
        return allowAll
    }
}
