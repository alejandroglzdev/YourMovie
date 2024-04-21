//
//  ListOfMoviesInteractor.swift
//  YourMovie
//
//  Created by Carlos Gonzalez2 on 20/4/24.
//

import Foundation

// abb2dd61afef88daf0476ef54d1bfb56

class ListOfMoviesInteractor {
    func getListOfMovies() async -> PopularMovieResponseEntity {
        let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=abb2dd61afef88daf0476ef54d1bfb56")!
        let(data, _) = try! await URLSession.shared.data(from: url)
        
        return try! JSONDecoder().decode(PopularMovieResponseEntity.self, from: data)
    }

}
