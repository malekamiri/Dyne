//
//  ExperienceCell.swift
//  Dyne
//
//  Created by Malek Amiri on 10/27/19.
//  Copyright © 2019 Malek Amiri. All rights reserved.
//

import UIKit

class ExperienceCell: UITableViewCell {


    
    @IBOutlet weak var experienceImage: UIImageView!
    @IBOutlet weak var experienceNameLabel: UILabel!
    @IBOutlet weak var restaurantLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var includesLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpCell(experienceName: String, restaurantName: String, price: Double, includes: [FoodItem], image: UIImage?) {
        self.experienceNameLabel.text = experienceName
        self.restaurantLabel.text = restaurantName
        self.priceLabel.text = "$\(price)"
        self.includesLabel.text = ""
        for item in includes {
            self.includesLabel.text = self.includesLabel.text! + item.name
            if (item.name != includes[includes.count - 1].name) {
                self.includesLabel.text = self.includesLabel.text! + ", "
            }
        }
        

        
        self.experienceImage.image = image
        
        
    }

}
