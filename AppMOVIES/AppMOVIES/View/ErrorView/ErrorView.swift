//
//  ErrorView.swift
//  AppMOVIES
//
//  Created by Alexandre Aun on 30/09/19.
//  Copyright © 2019 AleAun. All rights reserved.
//

import UIKit

class ErrorView: UIView {

    @IBOutlet weak var imageError: UIImageView!
    @IBOutlet weak var messageError: UILabel!
    
    var error: ValidationError?

    override init(frame: CGRect) {
        super.init(frame: frame)
      //  commomInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
       // commomInit()
    }
    
//    func commomInit() {
//        Bundle.main.loadNibNamed("ErrorView", owner: self, options: nil)
//        addSubview(imageError)
//        addSubview(messageError)
//        imageError.frame = self.frame
//        messageError.frame = self.frame
//    }
    
    func showError(){
        messageError.text = error?.imageError
    }
    

}
