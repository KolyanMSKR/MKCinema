//
//  Film.swift
//  MKCinema
//
//  Created by Admin on 1/10/21.
//

import Foundation

struct MoviesList: Codable {
    let films: [Film]
    let name: String

    enum CodingKeys: String, CodingKey {
        case films = "items"
        case name
    }
}

struct Film: Codable, Equatable {
    let id: Int
    let backdropPath: String
    let originalTitle: String
    let overview: String
    let posterPath: String
    let genreIDs: [Int]?
    let genres: [Genre]?
    let releaseDate: String
    let title: String
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case id
        case backdropPath = "backdrop_path"
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case genreIDs = "genre_ids"
        case genres
        case releaseDate = "release_date"
        case title
        case voteAverage = "vote_average"
    }
    
    static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}

struct Genre: Codable {
    let id: Int
    let name: String
}
