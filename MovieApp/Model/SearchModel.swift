//
//  SearchModel.swift
//  MovieApp
//
//  Created by Said Alır on 29.05.2021.
//

import Foundation

struct SearchResponseModel: Codable {

    var totalResults: String?
    var response: String?
    var result: [SearchResult]?
    
    enum CodingKeys: String, CodingKey {
        case totalResults
        case response = "Response"
        case result = "Search"
    }
}

struct SearchResult: Codable {
    var title: String?
    var year: String?
    var imdbID: String?
    var type: String?
    var posterUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case posterUrl = "Poster"
    }
}
