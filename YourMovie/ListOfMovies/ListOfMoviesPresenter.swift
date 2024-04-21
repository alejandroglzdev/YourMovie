//
//  ListOfMoviesPresenter.swift
//  YourMovie
//
//  Created by Carlos Gonzalez2 on 20/4/24.
//

import Foundation

protocol ListOfMoviesPresentable: AnyObject {
    var ui: ListOfMoviesUI? { get }
    var movieViewModels: [MovieViewModel] { get }
    func onViewAppear()
}

protocol ListOfMoviesUI: AnyObject {
    func update(movies: [MovieViewModel])
}

class ListOfMoviesPresenter: ListOfMoviesPresentable {
    weak var ui: ListOfMoviesUI?
    
    private let listOfMoviesInteractor: ListOfMoviesInteractable
    var movieViewModels: [MovieViewModel] = []
    private let mapper: MovieMapper
    
    init(listOfMoviesInteractor: ListOfMoviesInteractable,
         mapper: MovieMapper = MovieMapper()) {
        self.listOfMoviesInteractor = listOfMoviesInteractor
        self.mapper = mapper
    }
    
    func onViewAppear() {
        Task {
            let models = await listOfMoviesInteractor.getListOfMovies().results
            //Me petaba porque habia puesto let movieViewModels
            movieViewModels = models.map(mapper.map(entity:))
            ui?.update(movies: movieViewModels)
        }
    }
}
