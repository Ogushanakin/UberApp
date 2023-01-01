//
//  HomeController.swift
//  Uber
//
//  Created by AKIN on 31.12.2022.
//

import UIKit
import Firebase
import MapKit

final class HomeController: UIViewController {
    
    // MARK: - Properties
    
    private let mapView = MKMapView()
    
    // MARK - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkIfUserIsLoggedIn()
        //signOut()
    }
    
    // MARK: - API
    
    func checkIfUserIsLoggedIn() {
        if Auth.auth().currentUser?.uid == nil {
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginController())
                nav.modalPresentationStyle = .fullScreen
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
            print("DEBUG: Error signing out")
        }
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.addSubview(mapView)
        mapView.frame = view.frame
    }
    
}
