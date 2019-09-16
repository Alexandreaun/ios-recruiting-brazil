//
//  ValidationError.swift
//  AppMOVIES
//
//  Created by Alexandre Aun on 15/09/19.
//  Copyright © 2019 AleAun. All rights reserved.
//

import Foundation
import UIKit

class ValidationError: NSError{
    
    var imageError: String = ""
    
    init(imageError: String) {
        super.init(domain: imageError, code: 400, userInfo: [NSLocalizedDescriptionKey: imageError])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
