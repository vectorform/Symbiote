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
        
        view.backgroundColor = UIColor.red
        
        let presentButton = AnalyticsEnabledButton(frame: CGRect(x: 20, y: 20, width: 100, height: 50))
        presentButton.setTitle("Present NavigationController", for: UIControlState())
        presentButton.sizeToFit()
        presentButton.parentViewController = self
        presentButton.analyticsDescription = "PresentNavControllerButton"
        presentButton.addTarget(self, action: #selector(presentNavController), for: UIControlEvents.touchUpInside)
        view.addSubview(presentButton)

    }
    func presentNavController() {
        let nav = SampleNavigationController(rootViewController: SecondViewController())
        present(nav, animated: true, completion: nil)
    }
}
