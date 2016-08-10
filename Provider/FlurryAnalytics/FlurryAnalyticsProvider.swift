// Copyright (c) 2016 Vectorform LLC
// http://www.vectorform.com/
// http://github.com/vectorform/symbiote
//
//  Symbiote/Provider/FlurryAnalytics
//  FlurryAnalyticsProvider.swift
//

import Flurry_iOS_SDK

public class FlurryAnalyticsProvider: AnalyticsProvider {
    public init(apiKey: String) {
        Flurry.startSession(apiKey)
    }
    
    public func logEvent(event : Event) {
        var convertedData = Dictionary<NSString, NSString>()
        for (key, value) in event.data {
            convertedData[NSString(string: key)] = NSString(string: value)
        }
        Flurry.logEvent(event.method+":"+event.sender + "/" + event.action, withParameters: convertedData)
    }
}
