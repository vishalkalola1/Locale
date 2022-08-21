//
//  SearchPlacesView.swift
//  Locale
//
//  Created by vishal on 8/18/22.
//

import SwiftUI
import MapKit

struct SearchPlacesView: View {
    
    @StateObject var viewModel = SearchPlacesViewModel()
    
    @State private var selection: Segment.ViewStyle = .Map
    
    var body: some View {
        Navigation(title: viewModel.title, style: .inline) {
            VStack {
                SearchView { radius in
                    viewModel.searchPlaces(radius)
                }
                Segment(selection: $selection, data: viewModel.searchStyle)
                if selection == .Map {
                    Map(coordinateRegion: $viewModel.mapRegion, showsUserLocation: true, annotationItems: viewModel.places) { place in
                        MapAnnotation(coordinate: place.coordinate!) {
                            MapPinDetails(place: place)
                        }
                    }
                } else {
                    List(viewModel.places) { place in
                        MapDetails(name: place.name ?? "", address: place.location?.formattedAddress ?? "", categories: place.categories ?? [])
                    }
                }
            }
        }
    }
}

struct SearchPlacesView_Previews: PreviewProvider {
    static var previews: some View {
        SearchPlacesView()
    }
}
