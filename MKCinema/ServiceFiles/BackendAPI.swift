//
//  BackendAPI.swift
//  MKCinema
//
//  Created by Admin on 1/11/21.
//

import Foundation

class BackendAPI {
    private let networkService = NetworkService()
    private let apiKey = "0eba4e8ca4cc7aaecf80f10b2c5fdbe2"
    
    func fetchMoviesList(completion: @escaping (MoviesList?) -> ()) {
        guard let url = URL(string: "https://api.themoviedb.org/3/list/1?api_key=\(apiKey)&language=en-US") else {
            return
        }
        
        let request = URLRequest(url: url)
        networkService.fetchJSONData(request: request, modelType: MoviesList.self) { response in
            completion(response)
        }
    }
    
    func fetchGenres(movieID: Int, completion: @escaping (Film?) -> ()) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieID)?api_key=\(apiKey)&language=en-US") else {
            return
        }
        
        let request = URLRequest(url: url)
        networkService.fetchJSONData(request: request, modelType: Film.self) { response in
            completion(response)
        }
    }
    
}
