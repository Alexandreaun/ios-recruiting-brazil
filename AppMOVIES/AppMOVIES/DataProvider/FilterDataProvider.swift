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
    
    
    func filterYearMoviesFavorite() -> [String]{
        
        var yearMoviesFavorite: [String] = []
        
        for movie in movies{
            
            yearMoviesFavorite.append(movie.releaseDate.formateDateYear(dateString: movie.releaseDate))
            
        }
        
        let removeDuplicates = NSOrderedSet(array: yearMoviesFavorite)
        
        return removeDuplicates.array as? [String] ?? []
        
    }
    
    
  
    

    

    
}
