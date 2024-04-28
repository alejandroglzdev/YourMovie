//
//  ListOfMoviesInteractor.swift
//  YourMovie
//
//  Created by Carlos Gonzalez2 on 20/4/24.
//

import Foundation

// abb2dd61afef88daf0476ef54d1bfb56

protocol ListOfMoviesInteractable: AnyObject {
    func getListOfMovies() async throws -> PopularMovieResponseEntity
}

class ListOfMoviesInteractor: ListOfMoviesInteractable {
    func getListOfMovies() async throws -> PopularMovieResponseEntity {
        guard let url = URL(string: K.API.baseURL + K.API.endpointPopularMovies + K.API.apiKey)
        else {
            throw URLError(.badURL)
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode(PopularMovieResponseEntity.self, from: data)
        } catch {
            throw error
        }
    }
}

class ListOfMoviesInteractorMock: ListOfMoviesInteractable {
    func getListOfMovies() async -> PopularMovieResponseEntity {
        return PopularMovieResponseEntity(results: [
            .init(id: 0, title: "Esto es el primer ejemplo", overview: "Texto de ejemplo n.º 1", imageURL: "", votes: 10),
            .init(id: 1, title: "Esto es el segundo ejemplo", overview: "Texto de ejemplo n.º 2", imageURL: "", votes: 10),
            .init(id: 2, title: "Esto es el tercer ejemplo", overview: "Texto de ejemplo n.º 3", imageURL: "", votes: 10),
            .init(id: 3, title: "Esto es el primer ejemplo", overview: "Texto de ejemplo n.º 4", imageURL: "", votes: 10)
        ])
    }
    
    
}
