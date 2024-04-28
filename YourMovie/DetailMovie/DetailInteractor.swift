//
//  DetailInteractor.swift
//  YourMovie
//
//  Created by Carlos Gonzalez2 on 27/4/24.
//

import Foundation

protocol DetailInteractable: AnyObject {
    func getDetailMovie(withId id: String) async throws -> DetailMovieEntity
}

class DetailInteractor: DetailInteractable {
    func getDetailMovie(withId id: String) async throws -> DetailMovieEntity {
        guard let url = URL(string: K.API.baseURL + K.API.enpointMovieDetail + "/" + id + K.API.apiKey)
        else {
            throw URLError(.badURL)
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode(DetailMovieEntity.self, from: data)
        } catch {
            print("\n \n \(error)")
            throw error
        }
                
    }
}
