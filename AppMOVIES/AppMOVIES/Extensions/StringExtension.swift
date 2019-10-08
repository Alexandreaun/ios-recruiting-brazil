//
//  String.swift
//  AppMOVIES
//
//  Created by Alexandre Aun on 03/10/19.
//  Copyright © 2019 AleAun. All rights reserved.
//

import Foundation

extension String{
    
    func formateDateYear(dateString: String) -> String{
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let date = formatter.date(from: dateString)else{
            return ""
        }
        formatter.dateFormat = "yyyy"
        let year = formatter.string(from: date)
        formatter.dateFormat = "dd"
        let day = formatter.string(from: date)
        formatter.dateFormat = "MM"
        let month = formatter.string(from: date)
        
        return year
        
        
        
    }
    
    
    
    
}
