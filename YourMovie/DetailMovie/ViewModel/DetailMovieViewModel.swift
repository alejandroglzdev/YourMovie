//
//  DetailViewModel.swift
//  YourMovie
//
//  Created by Carlos Gonzalez2 on 27/4/24.
//

import Foundation

struct DetailMovieViewModel {
    let title: String
    let overview: String
    let backdropPath: URL?
    let voteAverage: Float
    let voteCount: Int
    let releaseDate: String
    let originalLanguage: String
}
