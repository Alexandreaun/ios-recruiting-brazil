//
//  Genres.swift
//  AppMOVIES
//
//  Created by Alexandre Aun on 16/09/19.
//  Copyright © 2019 AleAun. All rights reserved.
//

import Foundation


struct Genres: Codable {
    
    let genres: [Genre]
    
}

struct Genre: Codable {
    
    let id: Int
    let name: String
    
}
