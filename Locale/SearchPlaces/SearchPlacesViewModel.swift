//
//  SearchPlacesViewModel.swift
//  Locale
//
//  Created by vishal on 8/18/22.
//

import Foundation
import Combine
import MapKit.MKGeometry

struct SearchRequest {
    var latLong: String
    var lastRadius: String
    
    init(latLong: String = "", lastRadius: String = "") {
        self.latLong = latLong
        self.lastRadius = lastRadius
    }
    
    mutating func updateRadius(newRadius: String) {
        if lastRadius != newRadius {
            lastRadius = newRadius
        }
    }
}

final class SearchPlacesViewModel: ObservableObject {
    
    @Published var places: [Place] = []
    @Published var error: Error?
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 52.3595529, longitude: 4.8944762), span: MKCoordinateSpan(latitudeDelta: 0.8, longitudeDelta: 0.8))
    
    private let placesRepository: PlacesRepositoryProtocol
    private var cancellable: AnyCancellable?
    private var searchRequest = SearchRequest()
    
    init(placesRepository: PlacesRepositoryProtocol = PlacesRepository()) {
        self.placesRepository = placesRepository
        requestLocation()
        configureLocationObserver()
    }
    
    private var locationManager: LocationManager {
        LocationManager.shared
    }
    
    var searchStyle: [Segment.ViewStyle] {
        [.Map, .List]
    }
    
    var title: String {
        "Search Places"
    }
    
    private func requestLocation() {
        locationManager.requestLocation()
    }
    
    private func configureLocationObserver() {
        cancellable = locationManager.$coordinate.sink { [weak self] location in
            guard let self = self, let location = location else { return }
            self.searchRequest.latLong = location.latLong
            self.mapRegion = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.8, longitudeDelta: 0.8))
            self.searchPlaces(self.searchRequest.lastRadius)
        }
    }
    
    func searchPlaces(_ radius: String = "") {
        searchRequest.updateRadius(newRadius: radius)
        placesRepository.searchPlaces(by: radius, latLong: searchRequest.latLong) { [weak self] results in
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
