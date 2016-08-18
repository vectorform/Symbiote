// Copyright (c) 2016 Vectorform LLC
// http://www.vectorform.com/
// http://github.com/vectorform/symbiote
//
//  Symbiote/Core
//  AnalyticsProviders.swift
//

public protocol AnalyticsProvider: class {
    func logEvent(event: Event)
    
}
/// This allows Symbiote to use standard contains methods on collections by comparing the references of two objects
private func == (lhs: AnalyticsProvider, rhs: AnalyticsProvider) -> Bool {
    return lhs === rhs
}