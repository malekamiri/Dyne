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
    
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var timeField: UITextField!
    
    var name = "Daniel"
    
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
    
    @IBAction func editingDate(_ sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
         
        datePickerView.datePickerMode = UIDatePicker.Mode.date
         
        sender.inputView = datePickerView
         
        datePickerView.addTarget(self, action: #selector(OrderViewController.datePickerValueChanged), for: UIControl.Event.valueChanged)
    }
    @objc func datePickerValueChanged(sender: UIDatePicker) {
         
        let dateFormatter = DateFormatter()
         
        dateFormatter.dateFormat = "yyyy-MM-dd"
//        dateFormatter.dateStyle = .medium
//        dateFormatter.timeStyle = .none
         
        dateField.text = dateFormatter.string(from: sender.date)
         
    }
    @IBAction func editingTime(_ sender: UITextField) {
        let datePickerView: UIDatePicker = UIDatePicker()
         
        datePickerView.datePickerMode = UIDatePicker.Mode.time
         
        sender.inputView = datePickerView
         
        datePickerView.addTarget(self, action: #selector(OrderViewController.timePickerValueChanged), for: UIControl.Event.valueChanged)
    }
    @objc func timePickerValueChanged(sender: UIDatePicker) {
         
        let dateFormatter = DateFormatter()
         
        dateFormatter.dateFormat = "HH:mm:ss.SSS"
//        dateFormatter.dateStyle = .none
//        dateFormatter.timeStyle = .medium
         
        timeField.text = dateFormatter.string(from: sender.date)
         
    }
    @IBAction func pressedOnScreen(_ sender: Any) {
        timeField.resignFirstResponder()
        dateField.resignFirstResponder()
    }
    static func present(for cart: [FoodItem], restaurant: Restaurant, name: String, in navigationController: UINavigationController) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let orderVC = storyboard.instantiateViewController(withIdentifier: "orderViewController") as! OrderViewController

//        restaurantVC.distance = device.distance ?? (Double(device.RSSI ?? 0))
//        restaurantVC.device = device
        orderVC.cart = [FoodItem]()
        orderVC.cart = cart
        orderVC.restaurant = restaurant
        orderVC.name = name
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
        
        
        if let time = timeField.text {
            if let date = dateField.text {
                if let rest = restaurant {
                    if let cartt = cart {
                        
                        let dateTime = "\(date)T\(time)Z"
                        
                        sendOrder(items: cartt, restaurant: rest, date: dateTime, userName: name, partySize: Int(valueLabel?.text ?? "1") ?? 1)
                        
                        
                        var cartItemNames = cartt.map { $0.name }
                        var orderDescription = ""
                        orderDescription += "Restaurant: \(rest.name as! String) \n"
                        
                        for item in cartItemNames {
                            orderDescription += item
                            orderDescription += ", "
                        }
                        orderDescription += "\n Date: \(date)"
                        orderDescription += "\n Time: \(time)"
                        UserDefaults.standard.set(orderDescription, forKey: name)
                        
                        
                        let alert = UIAlertController(title: "Reservation sent successfully!", message: "You will be expected at the restaurant at \(timeField.text ?? "00:00")", preferredStyle: .alert)

                        alert.addAction(UIAlertAction(title: "Great!", style: .default) { (alert) in
                            _ = self.navigationController?.popToRootViewController(animated: true)
                        })

                        self.present(alert, animated: true)
                    }
                }
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
