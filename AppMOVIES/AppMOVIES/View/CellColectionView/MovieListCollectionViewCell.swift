//
//  MovieListCollectionViewCell.swift
//  AppMOVIES
//
//  Created by Alexandre Aun on 16/09/19.
//  Copyright © 2019 AleAun. All rights reserved.
//

import UIKit

protocol MovieListCellDelegate: class {
    func saveFavorite(index: IndexPath)
    func unfavoriteMovie(index: IndexPath) 
    
}



class MovieListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageMovieCell: UIImageView!
    @IBOutlet weak var titleMovieCell: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    weak var delegate:MovieListCellDelegate?
    let favoriteViewController = FavoriteViewController()
    let movielistDataProvider = MovieListDataProvider()
    let movieListViewController = MovieListViewController()
    let favoritesDataProvider = FavoritesDataProvider()
    
    let api = Api()
    var index: IndexPath!
    var indexUnfavorite: Int = 0
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupFavoriteButton()
    
    }
    
    func setupFavoriteButton() {
        let origImage = UIImage(named: "favoriteGrayIcon")
        let tintImage = origImage?.withRenderingMode(.alwaysTemplate)
        favoriteButton.setImage(tintImage, for: .normal)
        favoriteButton.tintColor = .lightGray
        
    }
    
    
    func setupCell(movies: Movies, index: IndexPath, returnFavorite: Bool){
        self.index = index
        titleMovieCell.text = movies.originalTitle
        
        let imageString = api.imageUrl+movies.posterPath
        
        guard let url = URL(string: imageString)else{
            imageMovieCell.backgroundColor = .lightGray
            return
        }
        do{
            let data = try Data(contentsOf: url)
            let imageData = UIImage(data: data)
            DispatchQueue.main.async {
                self.imageMovieCell.image = imageData

            }

            
        }catch{
            imageMovieCell.backgroundColor = .lightGray
        }
        
//        if returnFavorite == true{
//            favoriteButton.tintColor = .yellow
//        }
        



    }
    
    


        

    
    
    @IBAction func didTapFavoriteButton(_ sender: UIButton) {
        let row: Int = 1
        let indexUnfavorite2 = IndexPath(row: row + 2, section: 0)

        
       favoriteButton = sender
       favoriteButton.isSelected = !favoriteButton.isSelected
        
        if favoriteButton.isSelected{
        
   
        favoriteButton.tintColor = .orange
        

        delegate?.saveFavorite(index: index)
            print("favoritou")
        }else{
            
            favoriteButton.tintColor = .lightGray
        
            delegate?.unfavoriteMovie(index: index)
            print("desfavoritou")
            

            
        
        }
            
        

        
        
    }
    
    
}
