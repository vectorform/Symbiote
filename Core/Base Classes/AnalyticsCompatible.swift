// Copyright (c) 2016 Vectorform LLC
// http://www.vectorform.com/
// http://github.com/vectorform/symbiote
//
//  Symbiote/Core
//  AnalyticsBaseClass.swift
//

import UIKit

public protocol AnalyticsCompatible: class {
    var analyticsDescription: String? {get}
    weak var parentViewController: UIViewController? {get}

    func getViewPath() -> String;
}
