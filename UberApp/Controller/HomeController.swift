//
//  HomeController.swift
//  UberApp
//
//  Created by AKIN on 16.09.2022.
//

import UIKit
import Firebase
import MapKit

class HomeController: UIViewController {
    
    // MARK: - Properties
    
    private let mapView = MKMapView()
    private let locationManager = CLLocationManager()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfUserIsLoggedIn()
        enableLocationServices()
//        signOut()
    }
    
    // MARK: - API
    
    func checkIfUserIsLoggedIn() {
        if Auth.auth().currentUser?.uid == nil {
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginController())
                self.present(nav, animated: true, completion: nil)
            }
        } else {
            configureUI()
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("DEBUG : Error signing out")
        }
    }
    
    // MARK: - Helper Functions
    
    
    func configureUI() {
        configureMapView()
    }
    
    func configureMapView() {
        view.addSubview(mapView)
        mapView.frame = view.frame
        
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
    }
    
}

// MARK: - LocationServices

extension HomeController: CLLocationManagerDelegate {
    func enableLocationServices() {
        locationManager.delegate = self
        
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            print("DEBUG: Not determined")
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            break
        case .authorizedAlways:
            print("DEBUG: Auth always..")
            locationManager.startUpdatingLocation()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        case .authorizedWhenInUse:
            print("DEBUG: Auth when in use..")
            locationManager.requestAlwaysAuthorization()
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .authorizedWhenInUse {
            locationManager.requestAlwaysAuthorization()
        }
    }
}


