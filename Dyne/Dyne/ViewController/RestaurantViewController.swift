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
    
    var cart: [FoodItem]?
    
    @IBOutlet weak var foodItemsTable: UITableView!
    
    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var restaurantAddress: UILabel!
    
    var restaurant: Restaurant?
    var image: UIImage?
    var name: String = ""
    
    
    var userName = "Daniel"
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var viewOrderButton: UIButton!
    
    @IBOutlet weak var restaurantImage: UIImageView!
    static func present(for restaurant: Restaurant, image: UIImage, userName: String, in navigationController: UINavigationController) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let restaurantVC = storyboard.instantiateViewController(withIdentifier: "restaurantViewController") as! RestaurantViewController

//        restaurantVC.distance = device.distance ?? (Double(device.RSSI ?? 0))
//        restaurantVC.device = device
        restaurantVC.restaurant = restaurant
        restaurantVC.image = image
        restaurantVC.name = restaurant.name
        restaurantVC.userName = userName
        print(userName)
        navigationController.pushViewController(restaurantVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        restaurantName.text = name
        
        viewOrderButton.isHidden = true
        
        foodItems = [FoodItem]()
        
        foodItemsTable.delegate = self
        foodItemsTable.dataSource = self
        
        restaurantImage.image = image
        
        addressLabel.text = restaurant?.location
        
        getFoodItems()

    }
    

    func getFoodItems() {
//        var food1 = FoodItem(name: "Yellow Jacket Roll", price: 13.5)
//        var food2 = FoodItem(name: "California Roll", price: 15)
        
//        foodItems?.append(food1)
//        foodItems?.append(food2)
        
//        getItems(restaurant: restaurant) { (items) in
//            self.foodItems = items
//        }
        
        getItems(restaurant: restaurant!) { (items) in
            self.foodItems = items
            DispatchQueue.main.async {
                self.foodItemsTable.reloadData()
            }
        }
        
        
    }
    
    
    func addToCart(foodItem: FoodItem) {
        if (cart == nil) {
            cart = [FoodItem]()
            viewOrderButton.isHidden = false
        }
        cart!.append(foodItem)
        viewOrderButton.setTitle("View order (\(cart!.count))", for: .normal)
    }

    @IBAction func viewOrderWasPressed(_ sender: Any) {
        
        if let cartUnwrapped = cart {
            if let nav = self.navigationController {
                OrderViewController.present(for: cartUnwrapped, restaurant: restaurant!, name: userName, in: nav)
            }
            
        }
    }
}

extension RestaurantViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodItems == nil ? 0 : foodItems!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = foodItemsTable.dequeueReusableCell(withIdentifier: "foodItemCell") as? FoodItemCell else {
            return UITableViewCell()
        }
        if let item = foodItems?[indexPath.row] {
            cell.setUpCell(name: item.name, price: item.price)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = foodItems?[indexPath.row] {
            addToCart(foodItem: item)
        }
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
}
