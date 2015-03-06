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
        // Change the UI available options so that user knows the applicaiton is running
        RunBtn.enabled = false
        StopBtn.enabled = true
        
        // Informs the user through change in text that application is running
        activeLabel.text = "Running..."
        activeLabel.layer.addAnimation(anim, forKey: "pulse")
    }
    
    //Changes the UI when the user is done with logging
    func stopUI() {
        // Changes the UI available options so that user knows the application has been stopped
        RunBtn.enabled = true
        StopBtn.enabled = false
        
        // Informs the user through change in text that the application has been stopped
        activeLabel.text = "Inactive..."
        activeLabel.layer.removeAnimationForKey("pulse")
        lbl.text = "0"
    }
    
    
    // Sets up the animations for the app when it is running
    func setUpAnimation() {
        // Custom settings for animations that appear when the application is running
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
//        cllManager = CLLocationManager()
        // Start retrieving location data from CoreLocation API
        cllManager.startUpdatingLocation()
        // Check to make sure that there is a location being retrieved by the device
        if cllManager.location != nil {
            loc = cllManager.location
        }
        var velocity : Double = loc.speed
        // Update UI to inform user of current driving speed
        lblUpdate(velocity)
    }
    
    // Stop the API from retrieving location (Save Battery Power)
    func stopLocation() {
        cllManager.stopUpdatingLocation()
    }
    

    //================================================
    //======      Setup/Shutdown Functions      ======
    //================================================
    
    func runInitialization() {
        // Make the current class the delegate of the CLLocationManager and receive data from it
        cllManager.delegate = self
        
        // IOS 8 check to make sure app  has permission to run on phone
        let authstate = CLLocationManager.authorizationStatus()
        if authstate == CLAuthorizationStatus.NotDetermined {
            println("Not Authorised")
            cllManager.requestWhenInUseAuthorization()
        }
        
        // Custom settings to make speed measurements as accurate as possible
        cllManager.pausesLocationUpdatesAutomatically = false
        cllManager.desiredAccuracy = kCLLocationAccuracyBest
        cllManager.distanceFilter = kCLDistanceFilterNone
        
        // Start retrieving the location
        cllManager.startUpdatingLocation()
    }
    
    @IBAction func onStart(sender: AnyObject) {
        runInitialization()
        runUI()
        
        //Set up the timer to update the label displaying speed
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
        
        // Basic UI Setup upon application startup
        StopBtn.enabled = false
        RunBtn.enabled = true
        
        // Generate the animation settings for when the application is runnin
        setUpAnimation()
        
        // The timer for the application to retrieve speed using CoreLocation
        RATE = 1.0
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

