//
//  FilterViewController.swift
//  AppMOVIES
//
//  Created by Alexandre Aun on 01/10/19.
//  Copyright © 2019 AleAun. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {
    
    @IBOutlet weak var filterTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        filterTableView.delegate = self
        filterTableView.dataSource = self
        filterTableView.tableFooterView = UIView()
    }
    


}


extension FilterViewController: UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    if let cell = tableView.dequeueReusableCell(withIdentifier: "filterCell"){

        if indexPath.row == 0{
            cell.textLabel?.text = "Date"
            cell.detailTextLabel?.text = ""
        }else{
            cell.textLabel?.text = "Genres"
            cell.detailTextLabel?.text = ""
        }
        
        return cell

    }else{
        return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
            guard let vc = storyboard?.instantiateViewController(withIdentifier: "FilterDetailViewController") as? FilterDetailViewController else {return}
        
        if indexPath.row == 0{
        
          vc.index = indexPath
          vc.movie = FavoritesDataProvider.shared.arrayMovies
        navigationController?.pushViewController(vc, animated: true)
            
        }else{
            
            vc.index = indexPath
            vc.genres = FavoritesDataProvider.shared.arrayGenres
            navigationController?.pushViewController(vc, animated: true)
            
        }
        
    }
    
    
    
    
    
    
    
    
}
