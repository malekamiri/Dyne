//
//  Experience.swift
//  Dyne
//
//  Created by Malek Amiri on 10/27/19.
//  Copyright © 2019 Malek Amiri. All rights reserved.
//

import UIKit


class Experience {
    var name: String
    var restaurantName: String
    var price: Double
    var includes: [FoodItem]
    var image: UIImage?
    
    init(name: String, restaurantName: String, price: Double, includes: [FoodItem], image: UIImage?) {
        self.name = name
        self.restaurantName = restaurantName
        self.price = price
        self.includes = includes
        self.image = image
    }
}
