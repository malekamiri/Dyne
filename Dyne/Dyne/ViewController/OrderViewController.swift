//
//  OrderViewController.swift
//  Dyne
//
//  Created by Malek Amiri on 10/26/19.
//  Copyright © 2019 Malek Amiri. All rights reserved.
//

import UIKit

class OrderViewController: UIViewController {
    
    var cart: [FoodItem]?

    @IBOutlet weak var summaryTable: UITableView!
    
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    var total: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        summaryTable.delegate = self
        summaryTable.dataSource = self
        
        
        calculateTotal()
        
        summaryTable.reloadData()
    }
    
    static func present(for cart: [FoodItem], in navigationController: UINavigationController) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let orderVC = storyboard.instantiateViewController(withIdentifier: "orderViewController") as! OrderViewController

//        restaurantVC.distance = device.distance ?? (Double(device.RSSI ?? 0))
//        restaurantVC.device = device
        orderVC.cart = [FoodItem]()
        orderVC.cart = cart
        navigationController.pushViewController(orderVC, animated: true)
    }
    
    func calculateTotal() {
        if let cartt = cart {
            let sum = cartt.reduce(0){ $0 + $1.price }
            totalLabel.text = "$\(sum)"
        }
        
    }
    

    

}

extension OrderViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cart == nil ? 0 : cart!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = summaryTable.dequeueReusableCell(withIdentifier: "foodCartCell") as? FoodCartCell else {
            return UITableViewCell()
        }
        if let item = cart?[indexPath.row] {
            cell.setUpCell(name: item.name, price: item.price)
        }
        
        return cell
    }
    
    
}
