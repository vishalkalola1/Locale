//
//  PopularMoviesService.swift
//  Movies
//
//  Created by xdmgzdev on 19/04/2021.
//

import Foundation
import NetworkProvider

struct PlacesSearchService: NetworkService {
    
    var baseURL: String {
        CommonMovieService.baseURL
    }
    
    var method: HttpMethod {
        .get
    }
    
    var httpBody: Encodable? {
        nil
    }
    
    var headers: [String: String]? {
        [HttpHeaderKey.accept: MimeType.json.rawValue,
         HttpHeaderKey.authorization: CommonMovieService.apiKey]
    }
    
    var queryParameters: [URLQueryItem]? {
        [URLQueryItem(name: "ll", value: latLong),
         URLQueryItem(name: "radius", value: radius)]
    }
    
    var timeout: TimeInterval? {
        30
    }
    
    var path: String {
        "/places/search"
    }
    
    private var latLong: String
    private var radius: String
    
    internal init(latLong: String, radius: String) {
        self.latLong = latLong
        self.radius = radius
    }
}
