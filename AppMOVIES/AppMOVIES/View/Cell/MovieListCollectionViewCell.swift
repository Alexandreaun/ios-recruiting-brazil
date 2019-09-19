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
    
}


class MovieListCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imageMovieCell: UIImageView!
    @IBOutlet weak var titleMovieCell: UILabel!
    weak var delegate:MovieListCellDelegate?
    
    let api = Api()
    var index: IndexPath!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(movies: Movies, index: IndexPath, returnFavorite: Bool){
        self.index = index
        titleMovieCell.text = movies.title
        
        let imageString = api.imageUrl+movies.posterPath
        
        guard let url = URL(string: imageString)else{
            imageMovieCell.backgroundColor = .lightGray
            return
        }
        do{
            let data = try Data(contentsOf: url)
            imageMovieCell.image = UIImage(data: data)
        }catch{
            imageMovieCell.backgroundColor = .lightGray
        }
        
    }
    
    
    @IBAction func didTapFavoriteButton(_ sender: UIButton) {
        delegate?.saveFavorite(index: index)
    }
    
    
    
}
