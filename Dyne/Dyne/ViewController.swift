//
//  ViewController.swift
//  Dyne
//
//  Created by Malek Amiri on 10/26/19.
//  Copyright © 2019 Malek Amiri. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var restaurantTable: UITableView!
    
    
    var restaurants: [Restaurant]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        
        restaurantTable.delegate = self
        restaurantTable.dataSource = self
        
        getRestaurants()
    }
    
    func getRestaurants() {
        restaurants = [Restaurant]()
        let res1 = Restaurant(name: "Satto Thai and Sushi Bar", location: "768 Marietta St NW Suite A, Atlanta, GA 30318", openHour: 9, closeHour: 22, wait: 20)
        let res2 = Restaurant(name: "WaGaYa", location: "339 14th St NW, Atlanta, GA 30318", openHour: 11, closeHour: 17, wait: 15)
        restaurants?.append(res1)
        restaurants?.append(res2)
        restaurantTable.reloadData()
        
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants == nil ? 0 : restaurants!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = restaurantTable.dequeueReusableCell(withIdentifier: "restaurantCell") as? RestaurantCell else {
            return UITableViewCell()
        }
        if let restaurant = restaurants?[indexPath.row] {
            cell.setUpCell(restaurantName: restaurant.name, minWait: restaurant.wait, open: "Open Now", ratings: floor(Double.random(in: 3 ..< 5) * 10) / 10)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let restaurant = restaurants?[indexPath.row] {
            if let nav = self.navigationController {
                RestaurantViewController.present(for: restaurant, in: nav)
                }
            }
            
        }
        
    
    
}
