//
//  Enums.swift
//  MovieApp
//
//  Created by Said Alır on 29.05.2021.
//

import Foundation

typealias NetworkError = (Int, String)

enum IMDBType: String, Codable {
    case movie = "movie"
    case series = "series"
    case episode = "episode"
}

enum ConnectionType {
    case wifi
    case cellular
    case none
}
