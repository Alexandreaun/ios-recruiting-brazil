//
//  FilterViewController.swift
//  AppMOVIES
//
//  Created by Alexandre Aun on 01/10/19.
//  Copyright © 2019 AleAun. All rights reserved.
//

import UIKit

protocol FilterApplyDelegate: class {
    func loadDataFilter()
}

class FilterViewController: UIViewController {
    

    @IBOutlet weak var filterTableView: UITableView!
    
    weak var delegate: FilterApplyDelegate?
    var year: String?
    var genres: Genre?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        filterTableView.delegate = self
        filterTableView.dataSource = self
        filterTableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        filterTableView.reloadData()
    }
    
    @IBAction func applyFilterButton(_ sender: UIButton) {
        
//        guard let vc = storyboard?.instantiateViewController(withIdentifier: "FavoriteViewController") as? FavoriteViewController else {return}
        
        if year != nil || genres != nil{
            
            delegate?.loadDataFilter()
            
            navigationController?.popToRootViewController(animated: true)

        }else{
            let error = ValidationError(titleError: "Error", messageError: "Selecione algum dado para filtrar")
            showError(error: error, buttonLabel: "OK")
        }
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
                cell.detailTextLabel?.text = year
            }else{
                cell.textLabel?.text = "Genres"
                cell.detailTextLabel?.text = genres?.name
            }
            return cell
        } else{
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
            guard let vc = storyboard?.instantiateViewController(withIdentifier: "FilterDetailViewController") as? FilterDetailViewController else {return}
        
        if indexPath.row == 0{
        
          vc.index = indexPath
          vc.movie = FavoritesDataProvider.shared.arrayMovies
            vc.filterViewController = self
            navigationController?.pushViewController(vc, animated: true)
            
        }else{
            
            vc.index = indexPath
            vc.filterViewController = self
            vc.genres = FavoritesDataProvider.shared.arrayGenres
            navigationController?.pushViewController(vc, animated: true)
            
        }
    }
}
