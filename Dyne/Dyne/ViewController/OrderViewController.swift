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
    
    var restaurant: Restaurant?

    @IBOutlet weak var summaryTable: UITableView!
    
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    var total: Double = 0
    
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    @IBOutlet weak var timeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        summaryTable.delegate = self
        summaryTable.dataSource = self
        
        
        calculateTotal()
        
        summaryTable.reloadData()
        
        
        stepper.wraps = false
        stepper.value = 0
        stepper.minimumValue = 0
        stepper.maximumValue = 99
    }
    
    static func present(for cart: [FoodItem], restaurant: Restaurant, in navigationController: UINavigationController) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let orderVC = storyboard.instantiateViewController(withIdentifier: "orderViewController") as! OrderViewController

//        restaurantVC.distance = device.distance ?? (Double(device.RSSI ?? 0))
//        restaurantVC.device = device
        orderVC.cart = [FoodItem]()
        orderVC.cart = cart
        orderVC.restaurant = restaurant
        navigationController.pushViewController(orderVC, animated: true)
    }
    
    func calculateTotal() {
        if let cartt = cart {
            let sum = cartt.reduce(0){ $0 + $1.price }
            totalLabel.text = "$\(sum)"
        }
        
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        valueLabel.text = String(Int(floor(sender.value)))
        
    }
    
    @IBAction func sendOrderWasPressed(_ sender: Any) {
        if let rest = restaurant {
            if let cartt = cart {
                sendOrder(items: cartt, restaurant: rest, date: Date(), partySize: Int(valueLabel?.text ?? "1") ?? 1)
                let alert = UIAlertController(title: "Reservation sent successfully!", message: "You will be expected at the restaurant at \(timeLabel.text ?? "00:00")", preferredStyle: .alert)

                alert.addAction(UIAlertAction(title: "Great!", style: .default) { (alert) in
                    _ = self.navigationController?.popToRootViewController(animated: true)
                })

                self.present(alert, animated: true)
            }
            
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
