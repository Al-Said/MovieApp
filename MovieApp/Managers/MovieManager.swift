//
//  MovieManager.swift
//  MovieApp
//
//  Created by Said Alır on 29.05.2021.
//

import Foundation

class MovieManager {
    
    static let shared = MovieManager()

    func getMovieDetail(_ id: String,
                        success: @escaping (MovieModel) -> (),
                        failure: @escaping (NetworkError) -> ()) {
        
        var params: [String: Any] = [:]
        params["i"] = id
        APIManager.shared.get(path: "", headers: nil, params: params) { (data) in
            let decoder = JSONDecoder()
            do {
                let response = try decoder.decode(MovieModel.self, from: data)
                success(response)
            } catch {
                failure((0, "Data parse error!"))
            }
        } failure: { (code, message) in
            failure((code, message))
        }

    }
}
