//
//  FavoritesDataProvider.swift
//  AppMOVIES
//
//  Created by Alexandre Aun on 18/09/19.
//  Copyright © 2019 AleAun. All rights reserved.
//

import Foundation
import CoreData

class FavoritesDataProvider: NSObject{
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "AppMOVIES")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    
    var arrayDataMovies: [DataMovie] = []
    var arrayDataGenres: [DataGenres] = []

    var arrayMovies: [Movies] = []
    var arrayGenres: [Genre] = []

    
    func saveInformation(movie: Movies, genres: [Genre], indexpath: Int){
        
        let context = persistentContainer.viewContext
        let dataMovie = DataMovie(context: context)
        let dataGenres = DataGenres(context: context)
        
        dataMovie.title = movie.title
        dataMovie.adult = movie.adult
        dataMovie.backdropPath = movie.backdropPath
        dataMovie.id = Int64(movie.id)
        dataMovie.originalLanguage = movie.originalLanguage
        dataMovie.originalTitle = movie.originalTitle
        dataMovie.popularity = movie.popularity
        dataMovie.posterPath = movie.posterPath
        dataMovie.overview = movie.overview
        dataMovie.releaseDate = movie.releaseDate
        dataMovie.video = movie.video
        dataMovie.voteCount = Int16(movie.voteCount)
        dataMovie.voteAverage = movie.voteAverage
        dataMovie.genreIds = movie.genreIds
        
//        let genreIds: [Int]
//
//
//        dataGenres.id = Int16(genres[indexpath].id)
//        print(dataMovie)
        
        //dataMovie.dataGenres = dataMovie
//        dataMovie.dataGenres = NSSet(array: [dataGenres])
        
        do{
            try context.save()
        }catch{
            print(error.localizedDescription)
        }
        
    }
    
    func saveGenres(genres: [Genre]){
        let context = persistentContainer.viewContext
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "DataGenres")
        let request = NSBatchDeleteRequest(fetchRequest: fetch)
        
        do {
            try context.execute(request)
            try context.save()
        } catch {
            print ("There was an error")
        }

        
        for genre in genres {
            let dataGenres = DataGenres(context: context)
            dataGenres.id = Int16(genre.id)
            dataGenres.name = genre.name
        }
    
        do{
            try context.save()
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func loadInformation(completion: ([Movies]?, [Genre]?) -> Void){
        
        let context = persistentContainer.viewContext
        
        let request1 = NSFetchRequest<NSFetchRequestResult>(entityName: "DataMovie")
        let request2 = NSFetchRequest<NSFetchRequestResult>(entityName: "DataGenres")
        
        do{
            let result1 = try context.fetch(request1)
            let result2 = try context.fetch(request2)

            self.arrayDataMovies = result1 as? [DataMovie] ?? []
            self.arrayDataGenres = result2 as? [DataGenres] ?? []
            self.arrayMovies = transformableCoreDataToMovie(movies: self.arrayDataMovies)
            self.arrayGenres = transformableCoreDataToGenre(genres: self.arrayDataGenres)
            
            completion(arrayMovies, arrayGenres)
        } catch{
            print(error.localizedDescription)
            completion(nil, nil)
        }
        
    }
    
    func transformableCoreDataToMovie(movies: [DataMovie]) -> [Movies]{
        
        var newMovies: [Movies] = []
        
        for movie in movies{
            
            newMovies.append(Movies(popularity: movie.popularity, voteCount: Int(movie.voteCount), video: movie.video, posterPath: movie.posterPath ?? "", id: Int(movie.id), adult: movie.adult, backdropPath: movie.backdropPath, originalLanguage: movie.originalLanguage ?? "", originalTitle: movie.originalTitle ?? "", genreIds: movie.genreIds ?? [], title: movie.title ?? "", voteAverage: movie.voteAverage, overview: movie.overview ?? "", releaseDate: movie.releaseDate ?? ""))
        }
        
        return newMovies
        
    }
    
    func transformableCoreDataToGenre(genres: [DataGenres]) -> [Genre]{
        var newGenre: [Genre] = []
        
        for genre in genres {
            newGenre.append(Genre(id: Int(genre.id), name: genre.name ?? ""))
        }
        return newGenre
    }
    
    
    func deleteInformation(id: NSManagedObjectID, completion: (Bool) -> Void){
        let context = persistentContainer.viewContext
        let object = context.object(with: id)
        
        context.delete(object)
        
        do{
          try context.save()
          completion(true)
        }catch{
          completion(false)
        }
    }
    
    
}
