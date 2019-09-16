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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        moviesCollectionView.register(UINib(nibName: "MovieListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        
        movieListDataProvider.getMovies { (error) in
            if error == nil{
                print(self.movieListDataProvider.arrayMovies)
            }
        }
    }

}

extension MovieListViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieListDataProvider.numberOfItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? MovieListCollectionViewCell{
//
//        }
        
        return UICollectionViewCell()
    }
    
}
    

    
    
    
    
    
    
    
    
    
    
    
    

