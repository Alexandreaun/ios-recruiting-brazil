//
//  FilterDetailViewController.swift
//  AppMOVIES
//
//  Created by Alexandre Aun on 01/10/19.
//  Copyright © 2019 AleAun. All rights reserved.
//

import UIKit

class FilterDetailViewController: UIViewController {

    
    @IBOutlet weak var filterTableView: UITableView!
    
    
    var movie: [Movies]?
    var genres: [Genre]?
    var index = IndexPath()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filterTableView.delegate = self
        filterTableView.dataSource = self
    }
}

extension FilterDetailViewController: UITableViewDataSource, UITableViewDelegate{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if index.row == 0{
            
            guard let movies = movie else {return 0}
            return movies.count
            
        }else{
            
           guard let genre = genres else {return 0}
            return genre.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "FilterDetailCell", for: indexPath)
        
        if index.row == 0{
            
            guard let movies = movie else {return UITableViewCell()}

            cell.textLabel?.text = movies[indexPath.row].releaseDate

        }else{
            
            guard let genre = genres else {return UITableViewCell()}

            cell.textLabel?.text = genre[indexPath.row].name
            
        }
        
        return cell
        
    }


}
