//
//  ListOfMoviesRouter.swift
//  YourMovie
//
//  Created by Carlos Gonzalez2 on 20/4/24.
//

import Foundation
import UIKit

protocol PopularMoviesRouting {
    var detailRouter: DetailRouting? { get }
    var listOfMoviesView: ListOfMoviesView? { get }
    
    func showListOfMovies(window: UIWindow?)
    func showDetailMovie(withMovieID movieID: String)
}

class ListOfMoviesRouter: PopularMoviesRouting {
    var detailRouter: DetailRouting?
    var listOfMoviesView: ListOfMoviesView?
    
    func showListOfMovies(window: UIWindow?) {
        self.detailRouter = DetailRouter()
        let interactor = ListOfMoviesInteractor()
        let presenter = ListOfMoviesPresenter(listOfMoviesInteractor: interactor,
                                              router: self)

        listOfMoviesView = ListOfMoviesView(presenter: presenter)
        presenter.ui = listOfMoviesView
        //view.presenter = presenter
        
        window?.rootViewController = listOfMoviesView
        window?.makeKeyAndVisible()
    }
    
    func showDetailMovie(withMovieID movieID: String) {
        guard let fromViewController = listOfMoviesView else {
            return
        }
        
        detailRouter?.showDetail(fromViewControler: fromViewController, withMovieID: movieID)
    }

}
