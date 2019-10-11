//
//  MovieListCollectionViewCell.swift
//  AppMOVIES
//
//  Created by Alexandre Aun on 16/09/19.
//  Copyright © 2019 AleAun. All rights reserved.
//

import UIKit
import SDWebImage

protocol MovieListCellDelegate: class {
    func saveFavorite(index: IndexPath)
    func unfavoriteMovie(index: IndexPath) 
    
}



class MovieListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageMovieCell: UIImageView!
    @IBOutlet weak var titleMovieCell: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    weak var delegate:MovieListCellDelegate?
//    let favoriteViewController = FavoriteViewController()
    let movielistDataProvider = MovieListDataProvider()
    let movieListViewController = MovieListViewController()
    
    let api = Api()
    var index: IndexPath!
    
    
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
    
        imageMovieCell.sd_setImage(with: url) { (image, error, imageCachType, url) in
            if error != nil{
                self.imageMovieCell.backgroundColor = .lightGray
            }
        }
        
    
        if returnFavorite{
            favoriteButton.tintColor = .yellow
        }
        
    }
    
    
    @IBAction func didTapFavoriteButton(_ sender: UIButton) {

       favoriteButton.isSelected = !favoriteButton.isSelected

       favoriteButton = sender
        
        if favoriteButton.isSelected{
        

            favoriteButton.tintColor = .yellow
            
            
            delegate?.saveFavorite(index: index)
            print("favoritou")
        }else if !favoriteButton.isSelected{
            
            favoriteButton.tintColor = .lightGray
        
            delegate?.unfavoriteMovie(index: index)
            print("desfavoritou")
            

        }

    }
    
    
}
