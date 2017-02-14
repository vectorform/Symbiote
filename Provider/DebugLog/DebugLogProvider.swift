// Copyright (c) 2016 Vectorform LLC
// http://www.vectorform.com/
// http://github.com/vectorform/symbiote
//
//  Symbiote/Provider/DebugLog
//  DebugLogProvider.swift
//

open class DebugLogProvider: AnalyticsProvider {
    public init() {
    }
    open func log(event: Event) {
        NSLog("[SYMBIOTE]: " + event.method + ":" + event.sender + "/" + event.action + " [" + event.data.debugDescription + "]")
        
    }
}
