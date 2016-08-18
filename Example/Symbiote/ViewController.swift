// Copyright (c) 2016 Vectorform LLC
// http://www.vectorform.com/
// http://github.com/vectorform/symbiote
//
//  Symbiote/Example
//  ViewController.swift
//


import UIKit
import Symbiote

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //analyticsDescription = "FirstViewController"
        
        view.backgroundColor = UIColor.redColor()
        
        let presentButton = AnalyticsEnabledButton(frame: CGRectMake(20, 20, 100, 50))
        presentButton.setTitle("Present NavigationController", forState: UIControlState.Normal)
        presentButton.sizeToFit()
        presentButton.parentViewController = self
        presentButton.analyticsDescription = "PresentNavControllerButton"
        presentButton.addTarget(self, action: #selector(presentNavController), forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(presentButton)

    }
    func presentNavController() {
        let nav = SampleNavigationController(rootViewController: SecondViewController())
        presentViewController(nav, animated: true, completion: nil)
    }
}
