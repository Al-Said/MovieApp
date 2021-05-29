//
//  MovieTableCellViewModel.swift
//  MovieApp
//
//  Created by Said Alır on 29.05.2021.
//

import Foundation

class MovieTableCellViewModel {
    
    var title: String
    var year: String
    var type: IMDBType
    var poster: URL? = nil
    var id: String
    
    init(model: SearchResult) {
        self.id = model.imdbID ?? ""
        self.title = model.title ?? "Unknown"
        self.year = model.year ?? "Unknown"
        self.type = IMDBType.init(rawValue: model.type ?? "movie") ?? .movie
        if let urlStr = model.posterUrl {
            poster = URL(string: urlStr)
        }
    }
}
