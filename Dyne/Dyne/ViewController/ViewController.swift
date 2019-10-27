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
    
    var name: String = "Daniel"
    var phoneNumber: Int = 4045437582

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
                    let exp1 = Experience(name: "Birthday experience", restaurantName: "Naka Sushi", price: 18.0, includes: [FoodItem(name: "Rainbow Roll", price: 12, itemCategoryName: "SeaFood", externalItemId: "789654"),FoodItem(name: "California Roll", price: 6, itemCategoryName: "SeaFood", externalItemId: "887562")], image: image)
                    self.experiences.append(exp1)
                    DispatchQueue.main.async {
                        self.experienceTable.reloadData()
                    }
                }

        downloadImage(from: URL(string: "https://i.pinimg.com/originals/00/b9/c7/00b9c753623605ed6739ee2b9a1636cf.jpg")!) { (image) in
                    let exp2 = Experience(name: "Sounds Fishy", restaurantName: "Naka Sushi", price: 20.0, includes: [FoodItem(name: "Volcano Roll", price: 11, itemCategoryName: "SeaFood", externalItemId: "888999"),FoodItem(name: "Spicy Tuna", price: 9, itemCategoryName: "SeaFood", externalItemId: "666666")], image: image)
                    self.experiences.append(exp2)
                    DispatchQueue.main.async {
                        self.experienceTable.reloadData()
                    }
                }

        downloadImage(from: URL(string: "https://www.ourescapeclause.com/wp-content/uploads/2018/11/Colosseo-1170x789.jpg")!) { (image) in
                    let exp3 = Experience(name: "Mama Mia!", restaurantName: "Pasta Della Nona", price: 38.0, includes: [FoodItem(name: "Fettuccine Carbonara", price: 20, itemCategoryName: "Pasta", externalItemId: "187758"),FoodItem(name: "Penne al Fungi", price: 18, itemCategoryName: "Pasta", externalItemId: "1711868")], image: image)
                    self.experiences.append(exp3)
                    DispatchQueue.main.async {
                        self.experienceTable.reloadData()
                    }
                }

        downloadImage(from: URL(string: "https://cdn-image.travelandleisure.com/sites/default/files/styles/1600x1000/public/1485966971/romantic-RES0217.jpg?itok=FgHpWDYI")!) { (image) in
                    let exp4 = Experience(name: "Romantic Night", restaurantName: "Pasta Della Nona", price: 44.0, includes: [FoodItem(name: "Squid Ink Pasta", price: 19, itemCategoryName: "Pasta", externalItemId: "777666"),FoodItem(name: "Lobster Raviolli", price: 25, itemCategoryName: "Pasta", externalItemId: "577895")], image: image)
                    self.experiences.append(exp4)
                    DispatchQueue.main.async {
                        self.experienceTable.reloadData()
                    }
                }

        downloadImage(from: URL(string: "https://www.washingtonian.com/wp-content/uploads/2019/06/DC-4th-of-July-Brunch-Photo.jpg")!) { (image) in
                    let exp5 = Experience(name: "Sunday Brunch", restaurantName: "Le Fromage Grandiose", price: 19.0, includes: [FoodItem(name: "Croque Madame", price: 10, itemCategoryName: "French", externalItemId: "235790"),FoodItem(name: "Eggs Benedict", price: 9, itemCategoryName: "French", externalItemId: "556123")], image: image)
                    self.experiences.append(exp5)
                    DispatchQueue.main.async {
                        self.experienceTable.reloadData()
                    }
                }

        downloadImage(from: URL(string: "https://i1.wp.com/www.followmeaway.com/wp-content/uploads/2019/06/best-cafes-in-Paris-header.jpg?resize=700%2C467&ssl=1")!) { (image) in
                    let exp6 = Experience(name: "C'est la vie!", restaurantName: "Le Fromage Grandiose", price: 23.0, includes: [FoodItem(name: "Escargot", price: 15, itemCategoryName: "French", externalItemId: "666885"),FoodItem(name: "Aligot", price: 8, itemCategoryName: "French", externalItemId: "398147")], image: image)
                    self.experiences.append(exp6)
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
    
    @IBAction func editProfile(_ sender: Any) {
        
        var orderDescription = ""
        
        if let data = UserDefaults.standard.value(forKey: self.name) as? String {
            
            
            orderDescription = data
            
            
        }
        
        let alert = UIAlertController(title: "Edit your profile", message: orderDescription, preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Name"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Phone Number"
            textField.textContentType = .telephoneNumber
        }
        
        
        alert.addAction(UIAlertAction(title: "Set", style: .default) { (action) in
            self.name = alert.textFields?[0].text ?? "Daniel"
            self.phoneNumber = Int(alert.textFields?[1].text ?? "4045437582") ?? 4045437582
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive) { (action) in
            
        })

        self.present(alert, animated: true)
        
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
                        RestaurantViewController.present(for: restaurant, image: dict[restaurant.name]!, userName: self.name, in: nav)
                    }
                    
                }
            }
        } else {
            for rest in restaurants! {
                if (rest.name == experiences[indexPath.row].restaurantName) {
                    getItems(restaurant: rest) { (items) in
                        DispatchQueue.main.async {
                            OrderViewController.present(for: self.experiences[indexPath.row].includes, restaurant: rest, name: self.name, in: self.navigationController!)
                        }
                        
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
