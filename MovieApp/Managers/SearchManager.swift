//
//  SearchManager.swift
//  MovieApp
//
//  Created by Said Alır on 29.05.2021.
//

import Foundation

class SearchManager {
    
    static let shared = SearchManager()

    func getSearchResults(_ name: String,
                        success: @escaping (SearchResponseModel) -> (),
                        failure: @escaping (NetworkError) -> ()) {
        
        var params: [String: Any] = [:]
        params["s"] = name
        APIManager.shared.get(path: "", headers: nil, params: params) { (data) in
            let decoder = JSONDecoder()
            do {
                let response = try decoder.decode(SearchResponseModel.self, from: data)
                success(response)
            } catch {
                failure((0, "Data parse error!"))
            }
        } failure: { (code, message) in
            failure((code, message))
        }

    }
}
