//
//  Restaurant.swift
//  Dyne
//
//  Created by Malek Amiri on 10/26/19.
//  Copyright © 2019 Malek Amiri. All rights reserved.
//

import Foundation

class Restaurant {
    
    var name: String
    var location: String
    var openHour: Int
    var closeHour: Int
    var rating: Double
    var wait: Int
    
    init(name: String, location: String, openHour: Int, closeHour: Int, wait: Int) {
        self.name = name
        self.location = location
        self.openHour = openHour
        self.closeHour = closeHour
        self.rating = 4.4
        self.wait = wait
    }
}
