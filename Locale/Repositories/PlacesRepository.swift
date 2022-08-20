//
//  PlacesRepository.swift
//  Locale
//
//  Created by vishal on 8/18/22.
//

import Foundation
import NetworkProvider

protocol PlacesRepositoryProtocol {
    typealias PlacesResultHandler = (Result<PlacesResult, LocalError>) -> Void
    func searchPlaces(by radius: String, latLong: String, completion: @escaping PlacesResultHandler)
}

struct PlacesRepository: PlacesRepositoryProtocol {
    
    private var networkProvider: NetworkProviderProtocol
    
    init(networkProvider: NetworkProviderProtocol = NetworkProvider()) {
        self.networkProvider = networkProvider
    }
    
    func searchPlaces(by radius: String, latLong: String, completion: @escaping PlacesResultHandler) {
        let searchServices = PlacesSearchService(latLong: latLong, radius: radius)
        searchPlaces(service: searchServices, completion: completion)
    }
}

private extension PlacesRepository {
    func searchPlaces(service: NetworkService, completion: @escaping PlacesResultHandler) {
        networkProvider.request(dataType: PlacesResult.self, service: service, onQueue: .main) { result in
            completion(result)
        }
    }
}
