//
//  MovieMapper.swift
//  YourMovie
//
//  Created by Carlos Gonzalez2 on 21/4/24.
//

import Foundation

struct MovieMapper {
    func map(entity:PopularMovieEntity) -> MovieViewModel {
        MovieViewModel(title: entity.title,
                       overview: entity.overview,
                       imageURL: URL(string: "https://image.tmdb.org/t/p/w200" + entity.imageURL))
    }
}
