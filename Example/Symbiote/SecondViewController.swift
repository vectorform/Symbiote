//
//  SecondViewController.swift
//  Symbiote
//
//  Created by Johannes Start on 11/04/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import Symbiote

class SecondViewController: AnalyticsEnabledViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "SecondViewController in a NavController"
        analyticsDescription = "SecondViewController"
        
        view.backgroundColor = UIColor.green
        
        let dismissButton:AnalyticsEnabledButton = AnalyticsEnabledButton(frame: CGRect(x: 20, y: 80, width: 100, height: 50))
        dismissButton.setTitle("Dissmiss Nav+View Controller", for: UIControlState())
        dismissButton.sizeToFit()
        dismissButton.parentViewController = self
        dismissButton.analyticsDescription = "DismissButton"
        dismissButton.addTarget(self, action: #selector(SecondViewController.dismissView), for: UIControlEvents.touchUpInside)
        view.addSubview(dismissButton)
        
        
        let sampleEventButton:AnalyticsEnabledButton = AnalyticsEnabledButton(frame: CGRect(x: 20, y: 120, width: 100, height: 50))
        sampleEventButton.setTitle("Sample Event", for: UIControlState())
        sampleEventButton.sizeToFit()
        sampleEventButton.parentViewController = self
        sampleEventButton.analyticsDescription = "SampleEventButton"
        sampleEventButton.customEvent = Event(sender: AnalyticsExtensions.SampleSender, action: AnalyticsExtensions.SampleAction)
        sampleEventButton.addTarget(self, action: #selector(SecondViewController.sampleEvent), for: UIControlEvents.touchUpInside)
        view.addSubview(sampleEventButton)
        
    }
    
    func dismissView() {
        dismiss(animated: true, completion: nil)
    }
    func sampleEvent() {
        let alert = UIAlertView(title: "Sample Event", message: "This alert view was triggered by a sample event", delegate: self, cancelButtonTitle: "Ok")
        alert.show()
    }
}
