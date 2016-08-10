// Copyright (c) 2016 Vectorform LLC
// http://www.vectorform.com/
// http://github.com/vectorform/symbiote
//
//  Symbiote/Provider/GoogleAnalytics
//  GoogleAnalyticsProvider.swift
//

import Google


class GoogleAnalyticsProvider: AnalyticsProvider {
    
    init(trackUncaughtExceptions : Bool) {
        // Configure tracker from GoogleService-Info.plist.
        var configureError:NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services: \(configureError)")
        
        let gai = GAI.sharedInstance()
        gai.trackUncaughtExceptions = trackUncaughtExceptions
        
        //gai.logger.logLevel = GAILogLevel.Verbose  // remove before app release
    }
    
    func logEvent(event : AnalyticsEvent) {
        let tracker = GAI.sharedInstance().defaultTracker
        if (event.sender == EventSenders.View.rawValue) {
            tracker.set(kGAIScreenName, value: String(event.data[EventDataDescriptors.ViewName.rawValue]))
            let builder = GAIDictionaryBuilder.createScreenView()
            tracker.send(builder.build() as [NSObject : AnyObject])
        } else {
            tracker.send(GAIDictionaryBuilder.createEventWithCategory(event.sender, action: event.sender, label: String(event.data[EventDataDescriptors.SelectorName.rawValue]), value: nil).build() as [NSObject : AnyObject])
            
        }
    }
}
