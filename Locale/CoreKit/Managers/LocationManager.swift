//
//  LocationManager.swift
//  Locale
//
//  Created by vishal on 8/21/22.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var coordinate: CLLocationCoordinate2D?
    
    private let manager = CLLocationManager()

    public static let shared = LocationManager()
    
    private override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.startUpdatingLocation()
    }

    func requestLocation() {
        manager.requestWhenInUseAuthorization()
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse, .authorized:
            print("Location granted")
        default:
            print("Location denied")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinator = locations.last?.coordinate,
           coordinate?.latitude != coordinator.latitude,
           coordinate?.longitude != coordinator.longitude {
            coordinate = locations.last?.coordinate
        }
    }
}
