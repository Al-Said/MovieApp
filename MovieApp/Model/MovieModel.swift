//
//  MovieModel.swift
//  MovieApp
//
//  Created by Said Alır on 29.05.2021.
//

import Foundation

struct MovieModel: Codable {
    var title: String?
    var year: String?
    var releaseDay: String?
    var runtime: String?
    var poster: String?
    var genre: String?
    var director: String?
    var writer: String?
    var actors: String?
    var plot: String?
    var imdbRating: String?
    var metascore: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case releaseDay = "Released"
        case runtime = "Runtime"
        case poster = "Poster"
        case genre = "Genre"
        case director = "Director"
        case writer = "Writer"
        case actors = "Actors"
        case plot = "Plot"
        case imdbRating
        case metascore = "Metascore"
    }
}

