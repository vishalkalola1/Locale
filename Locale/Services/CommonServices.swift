//
//  MovieService.swift
//  Movies
//
//  Created by xdmgzdev on 14/04/2021.
//

import Foundation

enum CommonMovieService {
    
    static var baseURL: String {
        "https://api.foursquare.com/\(version)"
    }
    
    static var version: String {
        "v3"
    }
    
    static var apiKey: String {
        "fsq3zEYYPX3EvCvLn7rTPQK/Lu/CGjMP6GJebip0R11wM20="
    }
    
    static var limit: String {
        "50"
    }
}
