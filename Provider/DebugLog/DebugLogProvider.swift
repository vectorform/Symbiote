// Copyright (c) 2016 Vectorform LLC
// http://www.vectorform.com/
// http://github.com/vectorform/symbiote
//
//  Symbiote/Provider/DebugLog
//  DebugLogProvider.swift
//

public class DebugLogProvider: AnalyticsProvider {
    public init() {
    }
    public func logEvent(event: Event) {
        NSLog("[SYMBIOTE]: " + event.method + ":" + event.sender + "/" + event.action + " [" + event.data.debugDescription + "]");
        
    }
}
