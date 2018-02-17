//
//  ViewController.swift
//  Cerberus
//
//  Created by Navie Vurdien on 2/17/18.
//  Copyright © 2018 Treehacks2018. All rights reserved.
//

import UIKit
import CoreLocation


class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager();
    @IBOutlet weak var longitude: UILabel!
    @IBOutlet weak var latitude: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
            
        } else {
            print("Location services are not enabled");
        }
    }
        
        // Do any additional setup after loading the view, typically from a nib.
        
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            locationManager.stopUpdatingLocation()
            removeLoadingView()
            if ((error) != nil) {
                print(error)
            }
        }
        
        func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
            
            var currentLocation: CLLocation!
            
            if( CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
                CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways){
                
                currentLocation = locationManager.location;
                longitude.text = "\(currentLocation.coordinate.longitude)"
                latitude.text = "\(currentLocation.coordinate.latitude)"
                
            }
            
            
        }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func disableMyLocationBasedFeatures(){};
    
    func enableMyAlwaysFeatures(){};
    
    func removeLoadingView(){};
    
    
    
    func enableLocationServices() {
        
        locationManager.delegate = self
        
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            // Request always authorization
            locationManager.requestAlwaysAuthorization()
            break
            
        case .restricted, .denied:
            // Disable location features
            disableMyLocationBasedFeatures()
            break
            
        case .authorizedAlways:
            // Enable any of your app's location features
            enableMyAlwaysFeatures()
            break
        default:
            break
        }
    }
    
    
    func startReceivingLocationChanges() {
        
        let authorizationStatus = CLLocationManager.authorizationStatus()
        if authorizationStatus != .authorizedWhenInUse && authorizationStatus != .authorizedAlways {
            // User has not authorized access to location information.
            return
        }
        // Do not start services that aren't available.
        if !CLLocationManager.locationServicesEnabled() {
            // Location services is not available.
            return
        }
        // Configure and start the service.
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.distanceFilter = 100.0  // In meters.
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        
    }
    
    // MARK: - CoreLocation Delegate Methods
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        
        locationManager.stopUpdatingLocation()
        removeLoadingView()
        if ((error) != nil) {
            print(error)
        }
    }
    
    
}
