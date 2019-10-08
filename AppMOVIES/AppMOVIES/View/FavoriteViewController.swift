//
//  FavoriteViewController.swift
//  AppMOVIES
//
//  Created by Alexandre Aun on 16/09/19.
//  Copyright © 2019 AleAun. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var favoriteTableView: UITableView!
    
    let color = Colors()
    var movie: Movies?
    
    
    var filterViewController: FilterViewController?
  //  let filterDataProvider = FilterDataProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        favoriteTableView.register(UINib(nibName: "FavoriteTableViewCell", bundle: nil), forCellReuseIdentifier: "FavoriteTableViewCell")
        
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self
        searchBar.barTintColor = .black
        
        favoriteTableView.tableFooterView = UIView()
        
        filterViewController = self.storyboard?.instantiateViewController(withIdentifier: "filterStoryBoard") as? FilterViewController
        filterViewController?.delegate = self
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
        favoriteTableView.reloadData()
        // loadFavoriteMovie()
        
    }
    
    func loadFavoriteMovie() {
        FavoritesDataProvider.shared.loadInformation { (movies, genre) in
            if movies != nil{
                if let movie = movies{
                    favoriteTableView.reloadData()
                }
            }
        }
    }
    

    @IBAction func filterButton(_ sender: UIBarButtonItem) {
        
        navigationController?.pushViewController(filterViewController ?? FilterViewController(), animated: true)
        
    }
    
}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FavoritesDataProvider.shared.arrayMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteTableViewCell", for: indexPath) as? FavoriteTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setupCell(movie: FavoritesDataProvider.shared.arrayMovies[indexPath.row])

        
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
        FavoritesDataProvider.shared.deleteInformation(id: FavoritesDataProvider.shared.arrayDataMovies[index.row].objectID) { (deleted) in
            if deleted{
                loadFavoriteMovie()
            }else{
                print("It was not possible unfavorite the Movie")
            }

        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController{
            
            vc.movie = FavoritesDataProvider.shared.arrayMovies[indexPath.row]
            vc.genres = FavoritesDataProvider.shared.arrayGenres
            navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
    
}

extension FavoriteViewController: FilterApplyDelegate{
    
    func loadDataFilter() {
        
    FavoritesDataProvider.shared.arrayMovies = FavoritesDataProvider.shared.arrayMovies.filter({$0.releaseDate.formateDateYear(dateString: $0.releaseDate) == filterViewController?.year})

   }
    
    
}




