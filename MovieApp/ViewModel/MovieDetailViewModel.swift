//
//  MovieDetailViewModel.swift
//  MovieApp
//
//  Created by Said Alır on 29.05.2021.
//

import Foundation

class MovieDetailViewModel {
    var title: String?
    var year: String?
    var relaseDay: String?
    var runtime: String?
    var actors: [String]?
    var poster: URL?
    var genre: String?
    var director: String?
    var writer: String?
    var plot: String?
    var imdbRating: String?
    var metascore: String?
    var id: String?
    var hasInit = false
    
    var data: [String] = []

    init(id: String) {
        self.id = id
        self.title = nil
        self.year = nil
        self.relaseDay = nil
        self.runtime = nil
        self.actors = nil
        self.poster = nil
        self.genre = nil
        self.director = nil
        self.writer = nil
        self.plot = nil
        self.imdbRating = nil
        self.metascore = nil
    }
    
    func fetchData(_ completion: @escaping ()->()) {
        self.hasInit = true
        MovieManager.shared.getMovieDetail(self.id ?? "") { model in
            self.title  = model.title
            self.year = model.year
            self.relaseDay = model.releaseDay
            self.runtime = model.runtime
            self.poster = URL(string: model.poster ?? "")
            self.genre = model.genre
            self.director = model.director
            self.actors = model.actors?.components(separatedBy: ", ")
            self.writer = model.writer
            self.plot = model.plot
            self.imdbRating = model.imdbRating
            self.metascore = model.metascore
            self.setData()
            completion()
        } failure: { error in
            print(error)
        }
    }
    
    func setData() {
        self.data.append("Title: \(title ?? "UNKNOWN")")
        self.data.append("Genre: \(genre ?? "UNKNOWN")")
        self.data.append("Director: \(director ?? "UNKNOWN")")
        self.data.append("Year: \(year ?? "UNKNOWN")")
        self.data.append("Writer: \(writer ?? "UNKNOWN")")
        self.data.append("Release Day: \(relaseDay ?? "UNKNOWN")")
        self.data.append("Runtime: \(runtime ?? "UNKNOWN")")
        self.data.append("IMDB Rating: \(imdbRating ?? "UNKNOWN")")
        self.data.append("Metascore: \(metascore ?? "UNKNOWN")")
        if self.plot != nil {
            self.data.append("Read Plot")
        }
        if self.actors != nil || self.actors?.isEmpty == false {
            self.data.append("See actors")
        }
    }
}
