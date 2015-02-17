//
//  FirstViewController.swift
//  Spoiler_Swift_Beta
//
//  Created by Tausif Ahmed on 2/12/15.
//  Copyright (c) 2015 Spoiler. All rights reserved.
//

import UIKit
import CoreLocation

class FirstViewController: UIViewController, CLLocationManagerDelegate {
    
    //================================================
    //======        Global Variables (Temp)     ======
    //================================================
    @IBOutlet weak var RunBtn: UIButton!
    @IBOutlet weak var StopBtn: UIButton!
    
    @IBOutlet weak var lbl: UITextField!
    @IBOutlet weak var activeLabel: UITextField!
    var lblTimer : NSTimer =  NSTimer()
    
    var anim : CABasicAnimation = CABasicAnimation()
    
    var loc : CLLocation = CLLocation()
    var cllManager: CLLocationManager = CLLocationManager()
    var RATE : NSTimeInterval = NSTimeInterval()
    
    //================================================
    //======            UI Functions            ======
    //================================================
    
    
    // Update Speed Display
    func lblUpdate(velocity: Double) {
        var numStr : NSString = NSString(format: "%.0f", velocity)
        lbl.text = numStr
    }
    
    // Changes UI when the user starts logging speed
    func runUI() {
        RunBtn.enabled = false
        StopBtn.enabled = true
        activeLabel.text = "Running..."
        activeLabel.layer.addAnimation(anim, forKey: "pulse")
    }
    
    //Changes the UI when the user is done with logging
    func stopUI() {
        RunBtn.enabled = true
        StopBtn.enabled = false
        activeLabel.text = "Inactive..."
        activeLabel.layer.removeAnimationForKey("pulse")
        lbl.text = "0"
    }
    
    
    // Sets up the animations for the app when it is running
    func setUpAnimation() {
        anim.keyPath = "opacity"
        anim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        anim.repeatCount = Float.infinity
        anim.autoreverses = true
        anim.duration = 1.0
        
    }
    
    //================================================
    //======            API Functions           ======
    //================================================
    

    // Run the APIs to retrieve location and speed
    func tick() {
        cllManager = CLLocationManager()
        cllManager.startUpdatingLocation()
        if cllManager.location != nil {
            loc = cllManager.location
        }
        var velocity : Double = loc.speed
        lblUpdate(velocity)
    }
    
    func stopLocation() {
        cllManager.stopUpdatingLocation()
    }
    

    //================================================
    //======      Setup/Shutdown Functions      ======
    //================================================
    
    func runInitialization() {
        cllManager.delegate = self
        let authstate = CLLocationManager.authorizationStatus()
        if authstate == CLAuthorizationStatus.NotDetermined {
            println("Not Authorised")
            cllManager.requestWhenInUseAuthorization()
        }
        
        cllManager.pausesLocationUpdatesAutomatically = false
        cllManager.desiredAccuracy = kCLLocationAccuracyBest
        cllManager.distanceFilter = kCLDistanceFilterNone
        
        cllManager.startUpdatingLocation()
    }
    
    @IBAction func onStart(sender: AnyObject) {
        runInitialization()
        runUI()
        lblTimer = NSTimer.scheduledTimerWithTimeInterval(RATE, target: self, selector: "tick", userInfo: nil, repeats: true)
    }
    
    @IBAction func onStop(sender: AnyObject) {
        stopUI()
        stopLocation()
        lblTimer.invalidate()
    }
    
    //================================================
    //======        Standard Functions          ======
    //================================================
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        StopBtn.enabled = false
        RunBtn.enabled = true
        setUpAnimation()
        
        RATE = 1.0
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

