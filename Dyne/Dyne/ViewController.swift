//
//  ViewController.swift
//  Dyne
//
//  Created by Malek Amiri on 10/26/19.
//  Copyright © 2019 Malek Amiri. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var restaurantTable: UITableView!
    
    
    var restaurants: [Restaurant]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        restaurantTable.delegate = self
        restaurantTable.dataSource = self
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants == nil ? 0 : restaurants!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    }
    
    
}
