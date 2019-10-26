//
//  RestaurantViewController.swift
//  Dyne
//
//  Created by Malek Amiri on 10/26/19.
//  Copyright © 2019 Malek Amiri. All rights reserved.
//

import UIKit

class RestaurantViewController: UIViewController {

    var foodItems: [FoodItem]?
    
    static func present(for restaurant: Restaurant, in navigationController: UINavigationController) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let restaurantVC = storyboard.instantiateViewController(withIdentifier: "restaurantViewController") as! RestaurantViewController

//        restaurantVC.distance = device.distance ?? (Double(device.RSSI ?? 0))
//        restaurantVC.device = device
        navigationController.pushViewController(restaurantVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        foodItems = [FoodItem]()
        
        getFoodItems()

    }
    

    func getFoodItems() {
        var food1 = FoodItem(name: "Yellow Jacket Roll", price: 13.5)
        var food2 = FoodItem(name: "California Roll", price: 15)
    }

}
