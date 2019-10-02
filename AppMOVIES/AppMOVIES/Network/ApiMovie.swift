//
//  ApiManager.swift
//  AppMOVIES
//
//  Created by Alexandre Aun on 15/09/19.
//  Copyright © 2019 AleAun. All rights reserved.
//

import Foundation

class ApiMovie: Api{
    
    func getApiMovie(page: Int, completion: @escaping (Movie?, ValidationError?) -> Void){
        
        let param = "&page=\(page)"
        
        if let url = URL(string: ApiMovie().baseUrl+ApiMovie().apiKey+param){
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let httpResponse = response as? HTTPURLResponse{
                    
                    if httpResponse.statusCode == 200{
                        
                        if let data = data{
                            
                            do{
                                let decoder = JSONDecoder()
                                decoder.keyDecodingStrategy = .convertFromSnakeCase
                                let json = try decoder.decode(Movie.self, from: data)
                                completion(json, nil)
                            }catch{
                                
                                let error = ValidationError(imageError: "Não foi possível parsear os dados da Api")
                                
                                completion(nil, error)
                            }
                            
                        }
                        
                    }else{
                        let error = ValidationError(imageError: "Erro \(httpResponse.statusCode)")
                        completion(nil, error)
                    }
                }
            }.resume()
        }
    }
    
    func getApiGenres(completion: @escaping (Genres?, ValidationError?) -> Void){
        
        
        if let url = URL(string: ApiMovie().genreBaseUrl+ApiMovie().movieGenre+ApiMovie().apiKey){
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let httpResponse = response as? HTTPURLResponse{
                    
                    if httpResponse.statusCode == 200{
                        
                        if let data = data{
                            
                            do{
                                let decoder = JSONDecoder()
                                decoder.keyDecodingStrategy = .convertFromSnakeCase
                                let json = try decoder.decode(Genres.self, from: data)
                                completion(json, nil)
                            }catch{
                                
                                let error = ValidationError(imageError: "Não foi possível parsear os dados da Api")
                                
                                completion(nil, error)
                            }
                            
                        }
                        
                    }else{
                        let error = ValidationError(imageError: "Erro \(httpResponse.statusCode)")
                        completion(nil, error)
                    }
                }
            }.resume()
        }
        
    }

}
