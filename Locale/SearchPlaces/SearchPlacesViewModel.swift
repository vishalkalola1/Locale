//
//  SearchPlacesViewModel.swift
//  Locale
//
//  Created by vishal on 8/18/22.
//

import Foundation
import NetworkProvider
import MapKit

final class SearchPlacesViewModel: ObservableObject {
    
    @Published var places: [Place] = []
    @Published var error: Error?
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 52.3595529, longitude: 4.8944762), span: MKCoordinateSpan(latitudeDelta: 0.8, longitudeDelta: 0.8))
    
    private let placesRepository: PlacesRepositoryProtocol
    public var locationManager: LocationManager {
        LocationManager.shared
    }
    
    private var userLocation: String = ""
    
    init(placesRepository: PlacesRepositoryProtocol = PlacesRepository()) {
        self.placesRepository = placesRepository
        locationManager.requestLocation()
        configureLocationObserver()
    }
    
    func configureLocationObserver() {
        _ = locationManager.$location.sink { location in
            guard let location = location else { return }
            let latLong = "\(location.latitude),\(location.longitude)"
            self.userLocation = latLong
            //self.mapRegion = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.8, longitudeDelta: 0.8))
        }
    }
    
    func searchPlaces(_ radius: String) {
        placesRepository.searchPlaces(by: radius, latLong: userLocation) { [weak self] results in
            guard let self = self else { return }
            do {
                let placesResult = try results.get()
                self.places = placesResult.places ?? []
                self.mapRegion = MKCoordinateRegion(center: self.places.first!.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.8, longitudeDelta: 0.8))
            } catch {
                self.error = error
            }
        }
    }
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var location: CLLocationCoordinate2D?
    
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
        location = locations.last?.coordinate
    }
}
