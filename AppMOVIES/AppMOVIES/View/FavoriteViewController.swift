//
//  FavoriteViewController.swift
//  AppMOVIES
//
//  Created by Alexandre Aun on 16/09/19.
//  Copyright © 2019 AleAun. All rights reserved.
//

import UIKit

protocol FavoriteCellDelegate: class {
    func unfavoriteMovie(index: Int)
    
}

class FavoriteViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var favoriteTableView: UITableView!
    
    let color = Colors()
    let favoritesDataProvider = FavoritesDataProvider()
    var arrayMovies: [Movies] = []
    
    weak var delegate: FavoriteCellDelegate?


    
    override func viewDidLoad() {
        super.viewDidLoad()

        favoriteTableView.register(UINib(nibName: "FavoriteTableViewCell", bundle: nil), forCellReuseIdentifier: "FavoriteTableViewCell")
        
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self

        loadFavoriteMovie()

        searchBar.barTintColor = .black
        
        favoriteTableView.tableFooterView = UIView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadFavoriteMovie()
    }
    
    func loadFavoriteMovie() {
        favoritesDataProvider.loadInformation { (movies, genre) in
            if movies != nil{
                if let movie = movies{
                    self.arrayMovies = movie
                    favoriteTableView.reloadData()
                }
            }
        }
    }

}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritesDataProvider.arrayMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteTableViewCell", for: indexPath) as? FavoriteTableViewCell else{
            return UITableViewCell()
        }
    
        cell.setupCell(movie: arrayMovies[indexPath.row])
        
    return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let swipe = UIContextualAction(style: .normal, title: "Unfavorite") { (action, view, completion) in
            self.unfavoriteMovie(index: indexPath)
        }
        
        let swipeAction = UISwipeActionsConfiguration(actions: [swipe])
        
        swipe.backgroundColor = .red
        
        return swipeAction
    }
    
    func unfavoriteMovie(index: IndexPath) {
        
        favoritesDataProvider.deleteInformation(id: favoritesDataProvider.arrayDataMovies[index.row].objectID) { (deleted) in
            if deleted{
                loadFavoriteMovie()
            }else{
                print("It was not possible unfavorite the Movie")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController{
            
            vc.movie = favoritesDataProvider.arrayMovies[indexPath.row]
            vc.genres = favoritesDataProvider.arrayGenres
            navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
    
}




