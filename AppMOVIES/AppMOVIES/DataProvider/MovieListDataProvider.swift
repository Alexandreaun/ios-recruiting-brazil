//
//  MovieListDataProvider.swift
//  AppMOVIES
//
//  Created by Alexandre Aun on 15/09/19.
//  Copyright © 2019 AleAun. All rights reserved.
//

import Foundation

class MovieListDataProvider{
    
    let apimovie = ApiMovie()
    var arrayMovies: [Movies] = []
    
    func getMovies(completion: @escaping (ValidationError?) -> Void){
        
        apimovie.getApiMovie { (movie, error) in
            if error == nil{
                if let movies = movie{
                    self.arrayMovies = movies.results
                    completion(nil)
                    print(self.arrayMovies)
                    return
                }
            }else{
                completion(error)
                return
            }
        }

    }
    
    func numberOfItemsInSection() -> Int{
        
        return arrayMovies.count
        
    }
    
    
    
    
    
    
    
    
}
