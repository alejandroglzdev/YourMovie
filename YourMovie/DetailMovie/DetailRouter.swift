//
//  DetailRouter.swift
//  YourMovie
//
//  Created by Carlos Gonzalez2 on 27/4/24.
//

import Foundation
import UIKit

protocol DetailRouting: AnyObject {
    func showDetail(fromViewControler: UIViewController, withMovieID movieID: String)
}

class DetailRouter: DetailRouting {
    func showDetail(fromViewControler: UIViewController,
                    withMovieID movieID: String) {
        
        //Mover a otra clase para hacer el ensamblado
        
        let interactor = DetailInteractor()
        let presenter = DetailPresenter(movieID: movieID,
                                        interactor: interactor,
                                        mapper: MapperDetailMovieViewModel())
        let view = DetailView(presenter: presenter)
        
        //Mover a otra clase para hacer el ensamblado
        presenter.ui = view
        
        fromViewControler.present(view, animated: true)
    }
}
