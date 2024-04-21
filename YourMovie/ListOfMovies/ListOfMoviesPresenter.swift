//
//  ListOfMoviesPresenter.swift
//  YourMovie
//
//  Created by Carlos Gonzalez2 on 20/4/24.
//

import Foundation

protocol ListOfMoviesUI: AnyObject {
    func update(movies: [MovieViewModel])
}

class ListOfMoviesPresenter {
    var ui: ListOfMoviesUI?
    
    private let listOfMoviesInteractor: ListOfMoviesInteractor
    var movieViewModels: [MovieViewModel] = []
    
    init(listOfMoviesInteractor: ListOfMoviesInteractor) {
        self.listOfMoviesInteractor = listOfMoviesInteractor
    }
    
    func onViewAppear() {
        Task {
            let models = await listOfMoviesInteractor.getListOfMovies().results
            let movieViewModels = models.map { entity in
                MovieViewModel(title: entity.title, overview: entity.overview, imageURL: entity.imageURL)
            }
            ui?.update(movies: movieViewModels)
        }
    }
}
