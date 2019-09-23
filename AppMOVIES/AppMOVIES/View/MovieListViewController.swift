//
//  ViewController.swift
//  AppMOVIES
//
//  Created by Alexandre Aun on 14/09/19.
//  Copyright © 2019 AleAun. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var moviesCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    
    let movieListDataProvider = MovieListDataProvider()
    let favoritesDataProvider = FavoritesDataProvider()
    let favoriteViewController = FavoriteViewController()
    
    var arraySearchBar: [Movies] = []
    var searching: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.barTintColor = .black

        moviesCollectionView.register(UINib(nibName: "MovieListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        requestGenres()
        requestMovies()
        moviesCollectionView.dataSource = self
        moviesCollectionView.delegate = self
        searchBar.delegate = self
        
    }
    
    func requestGenres(){
        movieListDataProvider.getGenres { (error) in
            if error == nil{
                self.favoritesDataProvider.saveGenres(genres: self.movieListDataProvider.arrayGenres)
                self.favoritesDataProvider.loadInformation(completion: { (dataMovie, dataGenres) in
                    print(dataGenres, dataMovie)
                })
//                print(self.movieListDataProvider.arrayGenres)
            }
        }
    }
    
    
    func requestMovies(){
        movieListDataProvider.getMovies { (error) in
            if error == nil{
                DispatchQueue.main.async {
                    
                    self.moviesCollectionView.reloadData()
                }
                
            }
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.searchBar.resignFirstResponder()
    }
    
    
    
    
}

extension MovieListViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if searching{
            return arraySearchBar.count
        }else{
            return movieListDataProvider.numberOfItemsInSection()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? MovieListCollectionViewCell{
            
            cell.delegate = self
            
            
            let returnFavorite = favoritesDataProvider.arrayMovies.contains(where: {$0.id == movieListDataProvider.arrayMovies[indexPath.item].id})
            
            if searching{
            
            cell.setupCell(movies: arraySearchBar[indexPath.item], index: indexPath, returnFavorite: returnFavorite)
            
            }else{
            cell.setupCell(movies: movieListDataProvider.arrayMovies[indexPath.item], index: indexPath, returnFavorite: returnFavorite)
            cell.index = indexPath
            }
            return cell
        }else{
            return UICollectionViewCell()
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.size.width/2-10
        return CGSize(width: width, height: width*3/2 + 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if searching{
            if indexPath.item == (movieListDataProvider.page * 20) - 10{
                movieListDataProvider.page += 1
                requestMovies()
            }
        }else{
            
            if indexPath.item == (movieListDataProvider.page * 20) - 10{
                movieListDataProvider.page += 1
                requestMovies()
            }
            
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController{
            
            if searching{
                vc.movie = arraySearchBar[indexPath.item]
                vc.genres = movieListDataProvider.arrayGenres
                navigationController?.pushViewController(vc, animated: true)

            }else{
                vc.movie = movieListDataProvider.arrayMovies[indexPath.item]
                vc.genres = movieListDataProvider.arrayGenres
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}

extension MovieListViewController: MovieListCellDelegate{

    func saveFavorite(index: IndexPath) {
        print("Clicou na cell \(index)")
        if searching{
        favoritesDataProvider.saveInformation(movie: arraySearchBar[index.item], genres: movieListDataProvider.arrayGenres, indexpath: index.item)
        }else{
        favoritesDataProvider.saveInformation(movie: movieListDataProvider.arrayMovies[index.item], genres: movieListDataProvider.arrayGenres, indexpath: index.item)
        }
    }
    
    func unfavoriteMovie(index: IndexPath) {
        print("Clicou na cell \(index)")
        
        if searching{
            // configurar
        }else{
            
            
            favoritesDataProvider.deleteInformation(id: favoritesDataProvider.arrayDataMovies[index.item].objectID) { (deleted) in
                if deleted{
                    favoritesDataProvider.loadInformation(completion: { (movies, genre) in
                        if movies != nil{
                            if let movie = movies{
                                favoriteViewController.arrayMovies = movie
                            }else{
                                print("It was not possible unfavorite the Movie")
                            }
                            
                        }
                    })
                }
                
            }
            
            
        }
    }

}

extension MovieListViewController: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        arraySearchBar = movieListDataProvider.arrayMovies.filter({$0.title.prefix(searchText.count) == searchText})
        searching = true
        moviesCollectionView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    
    
}


    
    
    

    
    
    
    
    
    

