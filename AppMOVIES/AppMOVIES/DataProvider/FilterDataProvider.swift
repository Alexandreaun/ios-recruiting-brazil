//
//  FilterDataProvider.swift
//  AppMOVIES
//
//  Created by Alexandre Aun on 02/10/19.
//  Copyright © 2019 AleAun. All rights reserved.
//

import Foundation


class FilterDataProvider{
    
    let movies = FavoritesDataProvider.shared.arrayMovies
    let genres = FavoritesDataProvider.shared.arrayGenres
    
    func filterGenresMoviesFavorites() -> [String]{
        
        var genresMoviesFavorites: [String] = []
        
        for idGenres in genres{
            
            for movieIdGenre in movies{
                
                for id in movieIdGenre.genreIds{
                    
                    if id == idGenres.id{
                        
                        genresMoviesFavorites.append(idGenres.name)
                    }
                }
            }

        }
        
        let removeDuplicates = NSOrderedSet(array: genresMoviesFavorites)

        return removeDuplicates.array as? [String] ?? []
        
    }
    
    func formateYearMovie(movie: Movies) -> String{
        
        let dateString = movie.releaseDate
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let date = formatter.date(from: dateString)else{
            return ""
        }
        formatter.dateFormat = "yyyy"
        let year = formatter.string(from: date)
        
        return year
        
    }
    

    
}
