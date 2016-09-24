// Copyright (c) 2016 Vectorform LLC
// http://www.vectorform.com/
// http://github.com/vectorform/symbiote
//
//  Symbiote/Core
//  SimpleGenericFilter.swift
//

open class SimpleGenericFilter: EventFilter {
    var filterMethods: Array<Event.Method> = []
    var filterSenders: Array<Event.Sender> = []
    var filterActions: Array<Event.Action> = []

    
    var whitelist: Bool = true // if disabled this acts as a blacklist
    public init(whitelist: Bool = true) {
        self.whitelist = whitelist
    }
    public init(whitelist: Bool = true, filterMethods: Array<Event.Method> = [], filterSenders: Array<Event.Sender> = [], filterActions: Array<Event.Action> = []) {
        self.whitelist = whitelist
        self.filterMethods = filterMethods
        self.filterSenders = filterSenders
        self.filterActions = filterActions
    }
    
    open func filter(event: Event) -> Bool {
        let methodListed = (filterMethods.contains(event.method) || filterMethods.count == 0)
        let senderListed = (filterSenders.contains(event.sender) || filterSenders.count == 0)
        let actionListed = (filterActions.contains(event.action) || filterActions.count == 0)
        
        let listed = methodListed && senderListed && actionListed
        return whitelist ? listed: !listed;
    }

}
