//
//  ViewControllerExtension.swift
//  AppMOVIES
//
//  Created by Alexandre Aun on 15/09/19.
//  Copyright © 2019 AleAun. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    
    func showError(error: NSError, buttonLabel: String){
        
        let alert: UIAlertController = UIAlertController(title: error.domain, message: error.localizedDescription, preferredStyle: .alert)
        let actionOK: UIAlertAction = UIAlertAction(title: buttonLabel, style: .default, handler: nil)
        
        alert.addAction(actionOK)
        present(alert, animated: true, completion: nil)
        
    }

 
}
