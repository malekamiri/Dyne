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
    @IBOutlet weak var restaurantImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpCell(restaurantName: String, minWait: Int, open: String, ratings: Double, image: UIImage) {
        restaurantNameLabel.text = restaurantName
        minWaitLabel.text = "Minimum wait time: \(minWait)"
        openLabel.text = open
        if (open == "Closed") {
            openLabel.textColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        } else {
            openLabel.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        }
        ratingsLabel.text = "\(ratings) ⭐️"
        restaurantImage.image = image
        
    }

}
