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
    
    let filterDataProvider = FilterDataProvider()
    var filterViewController: FilterViewController?
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
            
        //   guard let genre = genres else {return 0}
            return filterDataProvider.filterGenresMoviesFavorites().count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "FilterDetailCell", for: indexPath)
        
        if index.row == 0{
            
            guard let movies = movie else {return UITableViewCell()}

            cell.textLabel?.text = filterDataProvider.formateYearMovie(movie: movies[indexPath.row])

        }else{
            

            cell.textLabel?.text = filterDataProvider.filterGenresMoviesFavorites()[indexPath.row]
            
        }
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        guard let vc = storyboard?.instantiateViewController(withIdentifier: "filterStoryBoard") as? FilterViewController else {return}

        
       if index.row == 0 {
            
            guard let movies = movie else {return}

            let setYear = filterDataProvider.formateYearMovie(movie: movies[indexPath.row])
            print("setou o ano \(setYear)")
            filterViewController?.year = setYear
//            vc.year = setYear
           // navigationController?.pushViewController(vc, animated: false)
            
        }else{
            let setGenre = filterDataProvider.filterGenresMoviesFavorites()[indexPath.row]
            print("setou o genre \(setGenre)")
            filterViewController?.genres = setGenre
//            vc.genres = setGenre
        }
        navigationController?.popViewController(animated: true)
    }


}
