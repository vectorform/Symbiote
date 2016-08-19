// Copyright (c) 2016 Vectorform LLC
// http://www.vectorform.com/
// http://github.com/vectorform/symbiote
//
//  Symbiote/Core
//  AnalyticsBaseClass.swift
//

import UIKit

public protocol AnalyticsCompatible: class {
    var analyticsDescription: String? { get set }
    weak var parentViewController: UIViewController? { get }

    func getViewPath() -> String
}

extension AnalyticsCompatible {
    
    public func defaultAnalyticsDescription() -> String {
        return String(self.dynamicType.self)
    }
    
    public func getViewPath() -> String {
        guard let parentObject = parentViewController else {
            return "/" + (analyticsDescription ?? defaultAnalyticsDescription())
        }
        
        if let parent = parentObject as? AnalyticsCompatible {
            return parent.getViewPath() + "/" + (analyticsDescription ?? defaultAnalyticsDescription())
        } else {
            return String(parentObject.dynamicType.self) + "/" + (analyticsDescription ?? defaultAnalyticsDescription())
        }
    }
}