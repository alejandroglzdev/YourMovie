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
    func onTapCell(atIndex: Int)
}

protocol ListOfMoviesUI: AnyObject {
    func update(movies: [MovieViewModel])
}

class ListOfMoviesPresenter: ListOfMoviesPresentable {
    weak var ui: ListOfMoviesUI?
    
    private let listOfMoviesInteractor: ListOfMoviesInteractable
    var movieViewModels: [MovieViewModel] = []
    private var models: [PopularMovieEntity] = []
    private let mapper: MovieMapper
    private let router: PopularMoviesRouting
    
    init(listOfMoviesInteractor: ListOfMoviesInteractable,
         mapper: MovieMapper = MovieMapper(),
         router: PopularMoviesRouting) {
        self.listOfMoviesInteractor = listOfMoviesInteractor
        self.mapper = mapper
        self.router = router
    }
    
    func onViewAppear() {
        Task {
            do {
                models = try await listOfMoviesInteractor.getListOfMovies().results
                //Me petaba porque habia puesto let movieViewModels
                movieViewModels = models.map(mapper.map(entity:))
                ui?.update(movies: movieViewModels)
                
            } catch let urlError as URLError{
                print("The URL is not correct or is null: \(urlError.localizedDescription)")
                
            } catch {
                print("There was an error retrieving data from API")
            }
            
        }
    }
    
    func onTapCell(atIndex: Int) {
        let movieID = models[atIndex].id
        router.showDetailMovie(withMovieID: movieID.description)
    }
}
