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
    var dict: [String: UIImage] = [:]
//    var images: [UIImage] = [UIImage]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        
        restaurantTable.delegate = self
        restaurantTable.dataSource = self
        
        getRestaurants()
        
        
        

    }
    
    func getRestaurants() {
        restaurants = [Restaurant]()
//        let res1 = Restaurant(name: "Satto Thai and Sushi Bar", location: "768 Marietta St NW Suite A, Atlanta, GA 30318", openHour: 9, closeHour: 22, wait: 20)
//        let res2 = Restaurant(name: "WaGaYa", location: "339 14th St NW, Atlanta, GA 30318", openHour: 11, closeHour: 17, wait: 15)
//        restaurants?.append(res1)
//        restaurants?.append(res2)
        
        getNearbyRestaurants { (restaurants) in
            self.restaurants = restaurants
            self.downloadImage(from: URL(string: "https://thenypost.files.wordpress.com/2019/09/junk-food-turns-kid-blind.jpg?quality=90&strip=all&w=1236&h=820&crop=1")!) { (image) in
                
                for restaurant in restaurants {
                    self.dict[restaurant.name] = image!
                }
                
                for restaurant in restaurants {
                    //self.dict[restaurant.name] = image!
                    let url = URL(string: restaurant.image_url)
                    self.downloadImage(from: url ?? URL(string: "https://thenypost.files.wordpress.com/2019/09/junk-food-turns-kid-blind.jpg?quality=90&strip=all&w=1236&h=820&crop=1")!) { (image) in
                        if let img = image {
                            self.dict[restaurant.name] = img
                            DispatchQueue.main.async {
                                
                                self.restaurantTable.reloadData()
                                
                            }
                        }
                        
                        
                    }
                    
                    
                }
            }
            
            
        }
        
        
    }
    
    //Image downloading
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL, completion: @escaping (UIImage?)->()) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            completion(UIImage(data: data))
            
        }
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants == nil ? 0 : restaurants!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = restaurantTable.dequeueReusableCell(withIdentifier: "restaurantCell") as? RestaurantCell else {
            return UITableViewCell()
        }
        if let restaurant = restaurants?[indexPath.row] {
            cell.setUpCell(restaurantName: restaurant.name, minWait: restaurant.wait, open: "Open Now", ratings: floor(Double.random(in: 3 ..< 5) * 10) / 10, image: dict[restaurant.name]!)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let restaurant = restaurants?[indexPath.row] {
            if let nav = self.navigationController {
                RestaurantViewController.present(for: restaurant, image: dict[restaurant.name]!, in: nav)
            }
        }
        
    }
        
    
    
}


extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
