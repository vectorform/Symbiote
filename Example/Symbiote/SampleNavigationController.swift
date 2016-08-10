// Copyright (c) 2016 Vectorform LLC
// http://www.vectorform.com/
// http://github.com/vectorform/symbiote
//
//  Symbiote/Example
//  SampleNavigationController.swift
//
import UIKit
import Symbiote

class SampleNavigationController: AnalyticsEnabledNavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        analyticsDescription = "SampleNavigationController"
    }
}
