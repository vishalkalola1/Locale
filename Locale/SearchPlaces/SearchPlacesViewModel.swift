//
//  SearchPlacesViewModel.swift
//  Locale
//
//  Created by vishal on 8/18/22.
//

import Foundation
import NetworkProvider
import Combine
import MapKit.MKGeometry

final class SearchPlacesViewModel: ObservableObject {
    
    @Published var places: [Place] = []
    @Published var error: Error?
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 52.3595529, longitude: 4.8944762), span: MKCoordinateSpan(latitudeDelta: 0.8, longitudeDelta: 0.8))
    
    private let placesRepository: PlacesRepositoryProtocol
    private var cancellable: AnyCancellable?
    
    public var locationManager: LocationManager {
        LocationManager.shared
    }
    
    var searchStyle: [Segment.ViewStyle] {
        [.Map, .List]
    }
    
    private var userLocation: String = ""
    private var lastRadius: String = ""
    
    init(placesRepository: PlacesRepositoryProtocol = PlacesRepository()) {
        self.placesRepository = placesRepository
        locationManager.requestLocation()
        configureLocationObserver()
    }
    
    func configureLocationObserver() {
        cancellable = locationManager.$coordinate.sink { location in
            guard let location = location else { return }
            let latLong = "\(location.latitude),\(location.longitude)"
            self.userLocation = latLong
            self.mapRegion = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.8, longitudeDelta: 0.8))
            self.searchPlaces(self.lastRadius)
        }
    }
    
    private func updateRadius(newRadius: String) {
        if lastRadius != newRadius {
            lastRadius = newRadius
        }
    }
    
    func searchPlaces(_ radius: String = "") {
        updateRadius(newRadius: radius)
        placesRepository.searchPlaces(by: radius, latLong: userLocation) { [weak self] results in
            guard let self = self else { return }
            do {
                let placesResult = try results.get()
                self.places = placesResult.places?.filter({ $0.coordinate != nil }) ?? []
            } catch {
                self.error = error
            }
        }
    }
}
