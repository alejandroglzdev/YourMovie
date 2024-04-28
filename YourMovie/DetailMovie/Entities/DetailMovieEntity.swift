//
//  DetailMovieEntity.swift
//  YourMovie
//
//  Created by Carlos Gonzalez2 on 27/4/24.
//

import Foundation

struct DetailMovieEntity: Decodable {
    let title: String
    let overview: String
    let backdropPath: String
    let status: String
    let releaseDate: String
    let voteAverage: Float
    let voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case title, overview, status
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
        case backdropPath = "backdrop_path"
    }
}
