//
//  Places.swift
//  Locale
//
//  Created by vishal on 8/18/22.
//

import Foundation
import MapKit

// MARK: - PlacesResult
struct PlacesResult: Codable {
    let places: [Place]?
    let context: Context?
    
    enum CodingKeys: String, CodingKey {
        case places = "results"
        case context
    }
}

// MARK: - Context
struct Context: Codable {
    let geoBounds: GeoBounds?

    enum CodingKeys: String, CodingKey {
        case geoBounds = "geo_bounds"
    }
}

// MARK: - GeoBounds
struct GeoBounds: Codable {
    let circle: CircleShape?
}

// MARK: - Circle
struct CircleShape: Codable {
    let center: Center?
    let radius: Int?
}

// MARK: - Center
struct Center: Codable {
    let latitude, longitude: Double?
}

// MARK: - Result
class Place: Codable, Identifiable, ObservableObject {
    
    let id: String
    let categories: [Category]?
    let distance: Int?
    let geocodes: Geocodes?
    let link: String?
    let location: Location?
    let name: String?
    let timezone: String?
    @Published var isExpand: Bool = false
    
    var coordinate: CLLocationCoordinate2D? {
        guard let lat = geocodes?.latitude,
              let long = geocodes?.longitude else { return nil }
        return CLLocationCoordinate2D(latitude: lat, longitude: long)
    }
    
    var imageUrl: URL? {
        categories?.first?.imageUrl
    }

    enum CodingKeys: String, CodingKey {
        case id = "fsq_id"
        case categories, distance, geocodes, link, location, name
        case timezone
    }
}

// MARK: - Category
struct Category: Codable {
    let id: Int
    let name: String?
    let icon: Icon?
    
    var imageUrl: URL? {
        guard let prefix = icon?.prefix,
              let sufix = icon?.suffix else {
            return nil
        }

        let stringUrl = prefix + "64" + sufix
        return URL(string: stringUrl)
    }
}

// MARK: - Icon
struct Icon: Codable {
    let prefix: String?
    let suffix: String?

    enum CodingKeys: String, CodingKey {
        case prefix = "prefix"
        case suffix
    }
}

// MARK: - Geocodes
struct Geocodes: Codable {
    let main, roof: Center?
    
    var latitude: Double? {
        main?.latitude
    }

    var longitude: Double? {
        main?.longitude
    }
}

// MARK: - Location
struct Location: Codable {
    let address, censusBlock: String?
    let country: String?
    let formattedAddress: String?
    let locality: String?
    let postcode: String?
    let region: String?
    let crossStreet: String?
    let neighborhood: [String]?
    let addressExtended: String?

    enum CodingKeys: String, CodingKey {
        case address
        case censusBlock = "census_block"
        case country
        case formattedAddress = "formatted_address"
        case locality, postcode, region
        case crossStreet = "cross_street"
        case neighborhood
        case addressExtended = "address_extended"
    }
}
