//
//  MovieDetailViewController.swift
//  AppMOVIES
//
//  Created by Alexandre Aun on 16/09/19.
//  Copyright © 2019 AleAun. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    let api = Api()
    var movie: Movies? = nil
    var genres: [Genre]?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupOutlets()
    }
    
    func setupOutlets(){
        guard let movie = movie else{
            return
        }
        titleLabel.text = movie.title
        yearLabel.text = movie.releaseDate
        descriptionLabel.text = movie.overview
        
        guard let genres = genres else{
            return
        }
        
        let qtdGenres = movie.genreIds.count
        
        var arrayNameGenres: [String] = []
        
        if qtdGenres > 0{
            
            for g in movie.genreIds{
                
                for idGenres in genres{
                    
                    if g == idGenres.id{
                        
                        arrayNameGenres.append(idGenres.name)
                    }
                    
                }
            }
            
            var namesGenres: String = ""
            
            for genres in arrayNameGenres{
                
                if genres == arrayNameGenres.last{
                    namesGenres += genres
                }else {
                    namesGenres += genres + "," + " "
                }
                
            }
            
            genresLabel.text = "\(namesGenres)"
            
        }else{
            genresLabel.text = "Filme sem informação de Gênero"
        }
        
        
        guard let back = movie.backdropPath else {
            imageView.backgroundColor = .lightGray
            return
        }
        
        let imageString = api.imageUrl+back
        
        guard let url = URL(string: imageString)else{
            imageView.backgroundColor = .lightGray
            return
        }
        do{
            let data = try Data(contentsOf: url)
            imageView.image = UIImage(data: data)
        }catch{
            imageView.backgroundColor = .lightGray
        }
        
        let dateString = movie.releaseDate
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let date = formatter.date(from: dateString)else{
            return
        }
        formatter.dateFormat = "yyyy"
        let year = formatter.string(from: date)
        formatter.dateFormat = "dd"
        let day = formatter.string(from: date)
        formatter.dateFormat = "MM"
        let month = formatter.string(from: date)
        yearLabel.text = "\(day)/\(month)/\(year)"
        
    }
    
}
