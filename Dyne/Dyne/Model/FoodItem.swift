//
//  FoodItem.swift
//  Dyne
//
//  Created by Malek Amiri on 10/26/19.
//  Copyright © 2019 Malek Amiri. All rights reserved.
//

import Foundation

class FoodItem {
    var name: String
    var price: Double
    var itemCategoryName: String
    
    init(name: String, price: Double, itemCategoryName: String) {
        self.name = name
        self.price = price
        self.itemCategoryName = itemCategoryName
    }
}
