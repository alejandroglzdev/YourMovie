//
//  MapperDetailMovieViewModel.swift
//  YourMovie
//
//  Created by Carlos Gonzalez2 on 27/4/24.
//

import Foundation

struct MapperDetailMovieViewModel {
    func map(entity: DetailMovieEntity) -> DetailMovieViewModel {
        .init(title: entity.title,
              overview: entity.overview,
              backdropPath: URL(string: K.API.imageBaseURL + entity.backdropPath),
              voteAverage: entity.voteAverage / 2,
              voteCount: entity.voteCount
        )
    }
}
