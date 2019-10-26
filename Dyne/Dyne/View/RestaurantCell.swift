//
//  RestaurantCell.swift
//  Dyne
//
//  Created by Malek Amiri on 10/26/19.
//  Copyright © 2019 Malek Amiri. All rights reserved.
//

import UIKit

class RestaurantCell: UITableViewCell {

    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var minWaitLabel: UILabel!
    @IBOutlet weak var openLabel: UILabel!
    @IBOutlet weak var ratingsLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpCell(restaurantName: String, minWait: Int, open: String, ratings: Double) {
        restaurantNameLabel.text = restaurantName
        minWaitLabel.text = "Minimum wait time: \(minWait)"
        openLabel.text = open
        ratingsLabel.text = "\(ratings) ⭐️"
        
    }

}
