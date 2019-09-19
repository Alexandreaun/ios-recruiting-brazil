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
        
        let qtd = movie.genreIds.count

        var nameGenres: [String] = []

        if qtd > 0{

            for index in 0...qtd{
                let indexPos = index + 1
                for g in movie.genreIds{

                    for idGenres in genres{

                        if g == idGenres.id{
                            
                            nameGenres.append(idGenres.name)
                            
                         //  genresLabel.text = "\(idGenres.name)"
                        }
                }
            }
             
                var varNameGenres: String = ""
                varNameGenres += nameGenres[indexPos]
                
               
            genresLabel.text = "\(varNameGenres),\(nameGenres[index]) "
                
        
            }
        }else{
            genresLabel.text = "Filme sem informação de Gênero"
        }
        
            
  
        guard let back = movie.backdropPath else {
            let imageString = api.imageUrl+movie.posterPath
            
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
    }

}
