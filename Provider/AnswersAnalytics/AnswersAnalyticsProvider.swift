// Copyright (c) 2016 Vectorform LLC
// http://www.vectorform.com/
// http://github.com/vectorform/symbiote
//
//  Symbiote/Provider/AnswersAnalytics
//  AnswersAnalyticsProvider.swift
//


import Fabric
import Crashlytics
import Symbiote


class AnswersAnalyticsProvider: AnalyticsProvider {
    
    init() {
    }
    
    func logEvent(event : Event) {
        Answers.logCustomEventWithName(event.sender + "/" + event.action, customAttributes: event.data)
    }
    
}