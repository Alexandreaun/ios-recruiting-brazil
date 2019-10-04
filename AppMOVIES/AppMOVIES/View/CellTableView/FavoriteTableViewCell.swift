//
//  FavoriteTableViewCell.swift
//  AppMOVIES
//
//  Created by Alexandre Aun on 20/09/19.
//  Copyright © 2019 AleAun. All rights reserved.
//

import UIKit
import SDWebImage


class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var labelYear: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelOverview: UILabel!
    @IBOutlet weak var imageMovie: UIImageView!
    
    let color = Colors()
    let api = Api()
    

    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func setupCell(movie: Movies){
        
        labelTitle.text = movie.originalTitle
        labelOverview.text = movie.overview
        
        let imageString = api.imageUrl+movie.posterPath
        
        guard let url = URL(string: imageString)else{
            imageMovie.backgroundColor = .lightGray
            return
        }
        
        imageMovie.sd_setImage(with: url) { (image, error, imageCachType, url) in
            if error != nil{
                self.imageMovie.backgroundColor = .lightGray
            }
        }
        
//        do{
//            let data = try Data(contentsOf: url)
//            imageMovie.image = UIImage(data: data)
//        }catch{
//            imageMovie.backgroundColor = .lightGray
//        }
        
        let dateString = movie.releaseDate
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let date = formatter.date(from: dateString)else{
            return
        }
        formatter.dateFormat = "yyyy"
        let year = formatter.string(from: date)
        
        labelYear.text = year
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    
    
    
}
