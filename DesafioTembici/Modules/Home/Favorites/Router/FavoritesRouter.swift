//
//  FavoritesRouter.swift
//  DesafioTembici
//
//  Created by Leo Valentim on 30/04/19.
//  Copyright © 2019 LeoValentim. All rights reserved.
//

import UIKit

protocol FavoritesRouterProtocol: class {
    func navigateToDetails(of model: MovieViewModel)
}

class FavoritesRouter: FavoritesRouterProtocol {
    static var storyBoard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
    
    private weak var view: FavoritesViewController?
    
    static func createModule() -> FavoritesViewController? {
        guard let view = storyBoard.instantiateViewController(withIdentifier: String(describing: FavoritesViewController.self)) as? FavoritesViewController else { return nil }
        
        let router = FavoritesRouter()
        let presenter = FavoritesPresenter()
        let interector = FavoritesInterector()
        
        router.view = view
        interector.presenter = presenter
        presenter.router = router
        presenter.interector = interector
        presenter.view = view
        view.presenter = presenter
        
        return view
    }
    
    func navigateToDetails(of model: MovieViewModel) {
        guard let movieDetails = MovieDetailsRouter.createModule(with: model) else {return}
        
        if let navigation = view?.navigationController {
            navigation.pushViewController(movieDetails, animated: true)
        } else {
            view?.present(movieDetails, animated: true, completion: nil)
        }
    }
}
