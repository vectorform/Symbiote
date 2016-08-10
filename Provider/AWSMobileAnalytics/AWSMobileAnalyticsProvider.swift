// Copyright (c) 2016 Vectorform LLC
// http://www.vectorform.com/
// http://github.com/vectorform/symbiote
//
//  Symbiote/Provider/AWSMobileAnalytics
//  AWSMobileAnalyticsProvider.swift
//

import AWSMobileAnalytics

public class AWSMobileAnalyticsProvider: AnalyticsProvider {
    let awsAnalytics : AWSMobileAnalytics;
    
    public init(appId: String, identityPoolId: String) {
        awsAnalytics = AWSMobileAnalytics(forAppId: appId, identityPoolId: identityPoolId)
    }
    
    public func logEvent(event : Event) {
        let awsEvent = awsAnalytics.eventClient.createEventWithEventType(event.method + ":" + event.sender + "/" + event.action)
        for (key, value) in event.data {
            awsEvent.addAttribute(key, forKey: value)
        }
        awsAnalytics.eventClient.recordEvent(awsEvent)
        awsAnalytics.eventClient.submitEvents()
    }
}
