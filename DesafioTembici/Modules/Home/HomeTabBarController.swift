//
//  HomeTabBarController.swift
//  DesafioTembici
//
//  Created by Leo Valentim on 29/04/19.
//  Copyright © 2019 LeoValentim. All rights reserved.
//

import UIKit

class HomeTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        let moviesView = MoviesRouter.createModule() ?? UIViewController()
        let firstItem = UINavigationController()
        firstItem.navigationBar.isTranslucent = false
        firstItem.navigationBar.barTintColor = #colorLiteral(red: 0.9664283395, green: 0.8098902106, blue: 0.3566762805, alpha: 1)
        firstItem.navigationBar.tintColor = .black
        firstItem.viewControllers = [moviesView]
        firstItem.tabBarItem.title = "Movies"
        firstItem.tabBarItem.image = UIImage(named: "list_icon")
        
        let favoritesView = FavoritesRouter.createModule() ?? UIViewController()
        let secondItem = UINavigationController()
        secondItem.navigationBar.isTranslucent = false
        secondItem.navigationBar.barTintColor = #colorLiteral(red: 0.9664283395, green: 0.8098902106, blue: 0.3566762805, alpha: 1)
        secondItem.navigationBar.tintColor = .black
        secondItem.viewControllers = [favoritesView]
        secondItem.tabBarItem.title = "Favorites"
        secondItem.tabBarItem.image = UIImage(named: "favorite_empty_icon")
        
        viewControllers = [firstItem, secondItem]
    }
    
}
