//
//  ApiManager.swift
//  AppMOVIES
//
//  Created by Alexandre Aun on 15/09/19.
//  Copyright © 2019 AleAun. All rights reserved.
//

import Foundation

class ApiMovie: Api{
    
    func getApiMovie(completion: @escaping (Movie?, ValidationError?) -> Void){
        
        if let url = URL(string: ApiMovie().baseUrl+ApiMovie().apiKey){
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let httpResponse = response as? HTTPURLResponse{
                    
                    if httpResponse.statusCode == 200{
                        
                        if let data = data{
                            
                            do{
                                let json = try JSONDecoder().decode(Movie.self, from: data)
                                completion(json, nil)
                            }catch{
                                
                                let error = ValidationError(imageError: "Erro ao carregar dados da Api")
                                
                                completion(nil, error)
                            }
                            
                        }
                        
    
                    }else{
                        let error = ValidationError(imageError: "Erro ao carregar dados da Api")
                        completion(nil, error)
                    }
                }
            }.resume()
            
            
        }
        

    }
    
    
    
    
    
    
    
}
