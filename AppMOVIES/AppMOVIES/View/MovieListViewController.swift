//
//  ViewController.swift
//  AppMOVIES
//
//  Created by Alexandre Aun on 14/09/19.
//  Copyright © 2019 AleAun. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController {

    @IBOutlet weak var moviesCollectionView: UICollectionView!

    let movieListDataProvider = MovieListDataProvider()
    let favoritesDataProvider = FavoritesDataProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        moviesCollectionView.register(UINib(nibName: "MovieListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        requestGenres()
        requestMovies()
        moviesCollectionView.dataSource = self
        moviesCollectionView.delegate = self
        
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

}

extension MovieListViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieListDataProvider.numberOfItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? MovieListCollectionViewCell{
            cell.delegate = self
            
            let returnFavorite = favoritesDataProvider.arrayMovies.contains(where: {$0.id == movieListDataProvider.arrayMovies[indexPath.item].id})
            cell.setupCell(movies: movieListDataProvider.arrayMovies[indexPath.item], index: indexPath, returnFavorite: returnFavorite)
            
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
        
        if indexPath.item == (movieListDataProvider.page * 20) - 10{
            
            movieListDataProvider.page += 1
            requestMovies()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController{
            
            vc.movie = movieListDataProvider.arrayMovies[indexPath.item]
            vc.genres = movieListDataProvider.arrayGenres
            navigationController?.pushViewController(vc, animated: true)
            
        }
    }
}

extension MovieListViewController: MovieListCellDelegate{
    func saveFavorite(index: IndexPath) {
        favoritesDataProvider.saveInformation(movie: movieListDataProvider.arrayMovies[index.item], genres: movieListDataProvider.arrayGenres, indexpath: index.item)
    }
}
    
    
    
    
    
    
    

