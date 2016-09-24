// Copyright (c) 2016 Vectorform LLC
// http://www.vectorform.com/
// http://github.com/vectorform/symbiote
//
//  Symbiote/Core
//  Symbiote.swift
//

import UIKit
/// FilteredEventProcessor is a tuple type that combines an event filter with a processor. If the filter returns `true` the processor may be executed on the tested event. If no filter is provided the processor may be applied to any event.
private typealias FilteredEventProcessor  = (filter: EventFilter?, processor: EventProcessor)

/// The main class needed to enable the Symbiote Analytics framework
final public class Symbiote {
    
    /// Only use this class parameter to access the Symbiote object
    public static let SharedInstance: Symbiote = Symbiote()
    
    /// This defines wether Symbiote should use swizzling to hook into SwizzleCompatible classes that are registered internally
    public static var swizzlingEnabled = true
    
    /// Classes that should be Swizzled; Musst comply to SwizzleCompatible; See UIApplication+SwizzledExtension.swift for sample
    fileprivate static let SwizzleClasses: [AnyClass] = [UIApplication.self, UIViewController.self]
    
    /// An array containing all enabled Analytics Providers
    fileprivate var analyticsProviders: Array<AnalyticsProvider> = []
    
    /// An array containing all event processors with the corresponding filter. Filters define if the processor may be applied to a given event
    fileprivate var filteredEventProcessors: Array<FilteredEventProcessor> = []
    
    /// The serial dispatch queue that is being used to log the events in order
    fileprivate let dispatchQueue = DispatchQueue(label: "com.symbiote.eventdispatch", attributes: [])

    
    /**
        Initializes a new Symbiote object. This should only be called once when first accessing the SharedInstance class parameter.
        
        - Returns: A beautiful, brand-new Symbiote object.
    */
    fileprivate init() {
        Symbiote.swizzleSwag()
    
        // Enable all default Processors
        register(eventProcessor: ViewEventScreenTimeProcessor())
    }
    
    /// Auto enables swizzling. To disable swizzling completely set swizzlingEnabled to false
    fileprivate static func swizzleSwag() {
        if swizzlingEnabled {
            func Swizzle(_ c: AnyClass!, methods: [Selector: Selector]) {
                for (from, to) in methods {
                    let originalSelector = from
                    let swizzledSelector = to
                    
                    let originalMethod = class_getInstanceMethod(c, originalSelector)
                    let swizzledMethod = class_getInstanceMethod(c, swizzledSelector)
                    
                    
                    let didAddMethod = class_addMethod(c, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
                    if didAddMethod {
                        class_replaceMethod(c, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
                    } else {
                        method_exchangeImplementations(originalMethod, swizzledMethod)
                    }
                    
                }
            }
            let swizzleOnce = {
                for c in Symbiote.SwizzleClasses {
                    if c is SwizzleCompatible.Type {
                        Swizzle(c as AnyClass!, methods: (c as! SwizzleCompatible.Type).SwizzleMethods)
                    }

                }
            }()
            _ = swizzleOnce
        }
    }
   
    // TODO: implement unregister
    /**
     Register a new Analytics Provider.
     - Parameter provider: The analytics provider that should be registered
     */
    public func register(analyticsProvider provider: AnalyticsProvider) {
        analyticsProviders.append(provider)
    }
    // TODO: implement unregister
    /**
        Register a new Event Processor with a filter.
        - Parameter eventProcessor: The event processor that should be executed on every filtered event.
        - Parameter filter: The filter that checks each event if it may/should be processed by the event processor
    */
    public func register(eventProcessor: EventProcessor, filter: EventFilter?) {
        filteredEventProcessors.append((filter, eventProcessor))
    }
    /**
        Register a a new event processor with it's default filter.
        - Parameter eventProcessor: The event processor that should be executed on every filtered event.
     */
    public func register(eventProcessor: EventProcessor) {
        register(eventProcessor: eventProcessor, filter: eventProcessor.defaultFilter())
    }
    /**
        This method makes sure each event is processed and written out to all enabled analytics providers, while dispatching this to a background priority queue.
        First the event will be matched against all processors and their corresponding filters. If a filter returns `true` for an event, it will be processed by the event processor. If the processor returns `false` then the event will not be sent to the analytics providers or processed any further.
        - Parameter event: The event that should be processed and sent to the analytics providers.
     */
    public func log(event: Event) {
        dispatchQueue.async { () -> Void in
            var event = event
            for filteredEventProcessor in self.filteredEventProcessors {
                var processEvent = true
                if let filter = filteredEventProcessor.filter {
                    processEvent = filter.filter(event: event)
                }
                if processEvent {
                    if !filteredEventProcessor.processor.process(event: &event) {
                        // event should not be published
                        // this will exit as soon as one of the event processors disables logging; no further event processors will be executed
                        return
                    }
                }
            }
            
            for a in self.analyticsProviders {
                a.log(event: event)
            }
        }
        
    }
    
}
