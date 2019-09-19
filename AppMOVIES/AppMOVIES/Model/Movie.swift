//
//  Movie.swift
//  AppMOVIES
//
//  Created by Alexandre Aun on 15/09/19.
//  Copyright © 2019 AleAun. All rights reserved.
//

import Foundation

struct Movie: Codable {
    let page: Int
    let totalResults: Int
    let totalPages: Int
    let results: [Movies]
    
    
//    enum CodingKeys: String, CodingKey {
//        case page
//        case totalResults = "total_results"
//        case totalPages = "total_pages"
//        case results
//    }
//    
    
}

struct Movies: Codable {
    let popularity: Double
    let voteCount: Int
    let video: Bool
    let posterPath: String
    let id: Int
    let adult: Bool
    let backdropPath: String?
    let originalLanguage: String
    let originalTitle: String
    let genreIds: [Int]
    let title: String
    let voteAverage: Double
    let overview: String
    let releaseDate: String

//
//    enum CodingKeys: String, CodingKey {
//        case popularity
//        case voteCount = "vote_count"
//        case video
//        case posterPath = "poster_path"
//        case id, adult
//        case backdropPath = "backdrop_path"
//        case originalLanguage = "original_language"
//        case originalTitle = "original_title"
//        case genreIDS = "genre_ids"
//        case title
//        case voteAverage = "vote_average"
//        case overview
//        case releaseDate = "release_date"
//    }


}
