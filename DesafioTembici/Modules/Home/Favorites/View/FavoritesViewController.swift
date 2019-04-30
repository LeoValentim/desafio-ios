//
//  FavoritesViewController.swift
//  DesafioTembici
//
//  Created by Leo Valentim on 30/04/19.
//  Copyright © 2019 LeoValentim. All rights reserved.
//

import UIKit

// MARK: - View
class FavoritesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noResultLabel: UILabel!
    
    let searchController = UISearchController(searchResultsController: nil)
    var presenter: FavoritesOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    @objc func didSetFavorite() {
        LoadingView.shared.hud.dismiss()
        presenter?.getMovies()
    }
    
    deinit {
        LocalDataManager.shared.removeObserver(self)
    }
}

// MARK: - View configuration methods
extension FavoritesViewController {
    func setupView() {
        title = "Favorites"
        
        LocalDataManager.shared.addObserver(self, selector: #selector(didSetFavorite))
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Favorite Movies"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: String(describing: FavoriteCell.self), bundle: nil), forCellReuseIdentifier: String(describing: FavoriteCell.self))
        
        LoadingView.shared.hud.show(in: view)
        presenter?.getMovies()
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
}

// MARK: - UISearchResultsUpdating Delegate
extension FavoritesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {return}
        presenter?.filterContentForSearchText(text)
    }
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.moviesCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FavoriteCell.self), for: indexPath) as? FavoriteCell,
            let model = presenter?.getMovie(at: indexPath.row) else { return UITableViewCell() }
        cell.setModel(model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.goToDetailsOfMovie(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let deleteAction = UIContextualAction(style: .destructive, title: "Unfavorite") { (action, view, handler) in
            LoadingView.shared.hud.show(in: self.view)
            self.presenter?.removeMovie(at: indexPath.row)
        }
        deleteAction.backgroundColor = .red
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
}

// MARK: - View / Presenter
protocol FavoritesInput: class {
    var isFiltering: Bool {get}
    func didGetMovies()
    func didFilter()
    func didFailure(_ error: Error)
}
extension FavoritesViewController: FavoritesInput {
    var isFiltering: Bool {
        get {
            return searchController.isActive && !searchBarIsEmpty()
        }
    }
    
    func didGetMovies() {
        LoadingView.shared.hud.dismiss()
        tableView.reloadData()
        let moviesCount = presenter?.moviesCount ?? 0
        noResultLabel.isHidden = moviesCount > 0
    }
    
    func didFilter() {
        tableView.reloadData()
    }
    
    func didFailure(_ error: Error) {
        LoadingView.shared.hud.dismiss()
        print("error: \(error)")
    }
}
