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

    @IBOutlet weak var experienceTable: UITableView!
    
    var restaurants: [Restaurant]?
    var dict: [String: UIImage] = [:]
//    var images: [UIImage] = [UIImage]()

    var experiences = [Experience]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        
        restaurantTable.delegate = self
        restaurantTable.dataSource = self
        
        experienceTable.delegate = self
        experienceTable.dataSource = self
        
        getRestaurants()
        getExperiences()
        
        
        

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
    
    func getExperiences() {
        downloadImage(from: URL(string: "https://scontent-atl3-1.xx.fbcdn.net/v/t1.0-9/23559501_1978864502385005_7428896850850924322_n.jpg?_nc_cat=106&_nc_oc=AQm64mKKXTqJaYsH2g0dswHYxwl38NXsvSqbEDeJfGms_Hf9O8zSOEV07pWSh-0ABAiwxqerr3bdzeJuP8l8su3X&_nc_ht=scontent-atl3-1.xx&oh=d9879b9bafdb57018f46ffb169903d2b&oe=5E630681")!) { (image) in
            let exp1 = Experience(name: "Birthday experience", restaurantName: "Satto Sushi", price: 15.0, includes: [FoodItem(name: "12 Sushis", price: 4, itemCategoryName: "SeaFood", externalItemId: "")], image: image)
            self.experiences.append(exp1)
            DispatchQueue.main.async {
                self.experienceTable.reloadData()
            }
        }
        
    }

    @IBAction func switchedTab(_ sender: UISegmentedControl) {
        switch (sender.selectedSegmentIndex) {
        case 0:
            restaurantTable.isHidden = false
            experienceTable.isHidden = true
        case 1:
            restaurantTable.isHidden = true
            experienceTable.isHidden = false
        default:
            restaurantTable.isHidden = false
            experienceTable.isHidden = true
        }
        
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == restaurantTable {
            return restaurants == nil ? 0 : restaurants!.count
        } else {
            return experiences.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (tableView == restaurantTable) {
            guard let cell = restaurantTable.dequeueReusableCell(withIdentifier: "restaurantCell") as? RestaurantCell else {
                return UITableViewCell()
            }
            if let restaurant = restaurants?[indexPath.row] {
                var open = "Closed"
                if (restaurant.name == "Naka Sushi" || restaurant.name == "Pasta Della Nona" || restaurant.name == "Le Fromage Grandiose") {
                    open = "Open Now"
                }
                restaurants?[indexPath.row].openHour = open == "Open Now" ? 1 : 0
                cell.setUpCell(restaurantName: restaurant.name, minWait: restaurant.wait, open: open, ratings: restaurant.rating, image: dict[restaurant.name]!)
            }
            
            return cell
        } else {
            guard let cell = experienceTable.dequeueReusableCell(withIdentifier: "experienceCell") as? ExperienceCell else {
                return UITableViewCell()
            }

            cell.setUpCell(experienceName: experiences[indexPath.row].name,  restaurantName: experiences[indexPath.row].restaurantName, price: experiences[indexPath.row].price, includes: experiences[indexPath.row].includes, image: experiences[indexPath.row].image)
            
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if (tableView == restaurantTable) {
            if let restaurant = restaurants?[indexPath.row] {
                if let nav = self.navigationController {
                    if (restaurant.openHour == 1) {
                        RestaurantViewController.present(for: restaurant, image: dict[restaurant.name]!, in: nav)
                    }
                    
                }
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
