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
        
        view.backgroundColor = UIColor.greenColor()
        
        let dismissButton:AnalyticsEnabledButton = AnalyticsEnabledButton(frame: CGRectMake(20, 80, 100, 50))
        dismissButton.setTitle("Dissmiss Nav+View Controller", forState: UIControlState.Normal)
        dismissButton.sizeToFit()
        dismissButton.parentViewController = self
        dismissButton.analyticsDescription = "DismissButton"
        dismissButton.addTarget(self, action: #selector(SecondViewController.dismissView), forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(dismissButton)
        
        
        let sampleEventButton:AnalyticsEnabledButton = AnalyticsEnabledButton(frame: CGRectMake(20, 120, 100, 50))
        sampleEventButton.setTitle("Sample Event", forState: UIControlState.Normal)
        sampleEventButton.sizeToFit()
        sampleEventButton.parentViewController = self
        sampleEventButton.analyticsDescription = "SampleEventButton"
        sampleEventButton.customEvent = Event(sender: AnalyticsExtensions.SampleSender, action: AnalyticsExtensions.SampleAction)
        sampleEventButton.addTarget(self, action: #selector(SecondViewController.sampleEvent), forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(sampleEventButton)
        
    }
    
    func dismissView() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    func sampleEvent() {
        let alert = UIAlertView(title: "Sample Event", message: "This alert view was triggered by a sample event", delegate: self, cancelButtonTitle: "Ok")
        alert.show()
    }
}
