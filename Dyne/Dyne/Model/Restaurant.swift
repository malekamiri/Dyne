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
    
    var clientId: String
    var clientSecret: String
    var image_url: String
    
    init(name: String, location: String, openHour: Int, closeHour: Int, wait: Int, clientId: String, clientSecret: String, image_url: String) {
        self.name = name
        self.location = location
        self.openHour = openHour
        self.closeHour = closeHour
        self.rating = 4.4
        self.wait = wait
        self.clientId = clientId
        self.clientSecret = clientSecret
        self.image_url = image_url
    }
}
