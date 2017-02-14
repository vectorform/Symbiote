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
    
    public func log(event : Event) {
        let awsEvent = awsAnalytics.eventClient.createEvent(withEventType: event.method + ":" + event.sender + "/" + event.action)
        if let awsEvent = awsEvent {
            for (key, value) in event.data {
                awsEvent.addAttribute(key, forKey: value)
            }
            awsAnalytics.eventClient.record(awsEvent)
            awsAnalytics.eventClient.submitEvents()
        }
    }
}
