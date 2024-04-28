//
//  DetailPresenter.swift
//  YourMovie
//
//  Created by Carlos Gonzalez2 on 27/4/24.
//

import Foundation

protocol DetailPresenterUI: AnyObject {
    func updateUI(viewmodel: DetailMovieViewModel)
}

protocol DetailPresentable: AnyObject {
    var ui: DetailPresenterUI? { get }
    var movieID: String { get }
    func onViewAppear()
}
class DetailPresenter: DetailPresentable {
    weak var ui: DetailPresenterUI?
    
    private let interactor: DetailInteractable
    private let mapper : MapperDetailMovieViewModel
    let movieID: String
    
    init(movieID: String, 
         interactor: DetailInteractable,
         mapper: MapperDetailMovieViewModel)
    {
        self.interactor = interactor
        self.movieID = movieID
        self.mapper = mapper
    }
    
    func onViewAppear() {
        do {
            Task {
                let model = try await interactor.getDetailMovie(withId: movieID)
                let viewModel = mapper.map(entity: model)
                await MainActor.run {
                    self.ui?.updateUI(viewmodel:viewModel)
                    print(viewModel)
                }
            }
            
        } catch let urlError as URLError{
            print("The URL is not correct or is null: \(urlError.localizedDescription)")
            
        } catch {
            print("There was an error retrieving data from API")
        }
    }
}
