//
//  File.swift
//  dyneDummy
//
//  Created by Marcelo Costa on 10/26/19.
//  Copyright © 2019 Marcelo Costa. All rights reserved.
//

import Foundation
import SwiftyJSON
var bearerToken = "";
func getNearbyRestaurants(completion: @escaping ([Restaurant]) -> ()) {
    let headers = [
      "nep-application-key": "8a0384356ddb119e016e06e12eb40037",
      "accept": "application/json",
      "Authorization": "Basic YWNjdDpyb290QGhhY2tfZHluZTpzQDdNMTlRXTJX",
      "User-Agent": "PostmanRuntime/7.19.0",
      "Cache-Control": "no-cache",
      "Postman-Token": "24bcfc22-b9ff-413c-87a9-d73252444e2a,19c72acf-319f-4aa7-9e9b-927567624b1d",
      "Host": "gateway-staging.ncrcloud.com",
      "Accept-Encoding": "gzip, deflate",
      "Cookie": "9e59b60fc083da305b706811d8f0d8f4=6b11b61b911198953617a5f3e6937154",
      "Connection": "keep-alive",
      "cache-control": "no-cache"
    ]
    let request = NSMutableURLRequest(url: NSURL(string: "https://gateway-staging.ncrcloud.com/site/sites/find-nearby/33,84?numSites=10&customAttributes=CREDENTIALS&radius=1000000000&customAttributes=IMAGE")! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
    request.httpMethod = "GET"
    request.allHTTPHeaderFields = headers
    let session = URLSession.shared
    let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) in
        if (error != nil) {
            print(error)
        } else {
            let httpResponse = response as? HTTPURLResponse
            if let dataUnwrapped = data {
                do {
                    let json = try JSON(data: dataUnwrapped)
                    
                    var restaurants = [Restaurant]()
                    
                    for i in 0..<json["sites"].count {
                        
                        let name = json["sites"][i]["siteName"].string ?? ""
                        var location = json["sites"][i]["address"]["street"].string ?? ""
                        location += ", "
                        location += json["sites"][i]["address"]["city"].string ?? ""
                        location += ", "
                        location += json["sites"][i]["address"]["state"].string ?? ""
                        location += ", "
                        location += json["sites"][i]["address"]["postalCode"].string ?? ""
                        let openHour = 9
                        let closeHour = 12
                        let rating = floor(Double.random(in: 3 ..< 5) * 10) / 10
                        let wait = 20
                        let clientId: String;
                        let clientSecret: String;
                        let image_url: String;
                        if (json["sites"][i]["customAttributeSets"][1]["typeName"].string == "IMAGE") {
                            var test = json["sites"][i]["customAttributeSets"][0]["attributes"][1]["key"].string
                            if (json["sites"][i]["customAttributeSets"][0]["attributes"][1]["key"].string == "client_id") {
                                clientId = json["sites"][i]["customAttributeSets"][0]["attributes"][1]["value"].string ?? ""
                                clientSecret = json["sites"][i]["customAttributeSets"][0]["attributes"][0]["value"].string ?? ""
                            } else {
                                clientId = json["sites"][i]["customAttributeSets"][0]["attributes"][0]["value"].string ?? ""
                                clientSecret = json["sites"][i]["customAttributeSets"][0]["attributes"][1]["value"].string ?? ""
                            }
                            image_url = json["sites"][i]["customAttributeSets"][1]["attributes"][0]["value"].string ?? ""
                        } else {
                            var test = json["sites"][i]["customAttributeSets"][1]["attributes"][1]["key"].string
                            if (json["sites"][i]["customAttributeSets"][1]["attributes"][1]["key"].string == "client_id") {
                                clientId = json["sites"][i]["customAttributeSets"][1]["attributes"][1]["value"].string ?? ""
                                clientSecret = json["sites"][i]["customAttributeSets"][1]["attributes"][0]["value"].string ?? ""
                            } else {
                                clientId = json["sites"][i]["customAttributeSets"][1]["attributes"][0]["value"].string ?? ""
                                clientSecret = json["sites"][i]["customAttributeSets"][1]["attributes"][1]["value"].string ?? ""
                            }
                            image_url = json["sites"][i]["customAttributeSets"][0]["attributes"][0]["value"].string ?? ""
                        }
                        
                        restaurants.append(Restaurant(name: name, location: location, openHour: openHour, closeHour: closeHour, wait: wait, clientId: clientId, clientSecret: clientSecret, image_url: image_url, rating: rating))
                        
            
                    }
                    completion(restaurants)
                } catch {
                    print("json unwrapping error")
                }
            }
        }
    }
    dataTask.resume()
}
func getItems(restaurant: Restaurant, completion: @escaping ([FoodItem]) -> ()) {
        let headers = [
          "Accept": "application/json",
          "client_id": restaurant.clientId,
          "client_secret": restaurant.clientSecret,
          "User-Agent": "PostmanRuntime/7.19.0",
          "Cache-Control": "no-cache",
          "Postman-Token": "65c63312-362d-4902-bc98-d4f682689ce5,63b88ae3-eb12-4dff-b8f5-08291a3df698",
          "Host": "api-reg-apigee.ncrsilverlab.com",
          "Accept-Encoding": "gzip, deflate",
          "Cookie": "AWSELB=81E1F51104C9DF4BC9F1DB6A797269745F78B96347F9C17420F2211EFA902D2F95DCFCE98A0AE03DD95CCA4CCB77DD16F4C11AFF2F1FA62D8EA17D482448126747F102B836",
          "Connection": "keep-alive",
          "cache-control": "no-cache"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://api-reg-apigee.ncrsilverlab.com/v2/oauth2/token")! as URL,cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
          if (error != nil) {
            print(error)
          } else {
            let httpResponse = response as? HTTPURLResponse
            if let dataUnwrapped = data {
                do {
                    let json = try JSON(data: dataUnwrapped)
                    let AccessToken = "Bearer " + (json["Result"]["AccessToken"].string ?? "")
                    bearerToken = AccessToken
                    let headers2 = [
                      "nep-application-key": "8a0384356ddb119e016e06e12eb40037",
                      "Authorization": AccessToken,
                      "Content-Type": "application/json",
                      "User-Agent": "PostmanRuntime/7.19.0",
                      "Accept": "/",
                      "Cache-Control": "no-cache",
                      "Postman-Token": "3f65ef4f-912c-45f8-a57e-e51791a089f6,e3bb055d-d911-4fdd-9188-f8421290c823",
                      "Host": "api-reg-apigee.ncrsilverlab.com",
                      "Accept-Encoding": "gzip, deflate",
                      "Cookie": "AWSELB=81E1F51104C9DF4BC9F1DB6A797269745F78B96347F0F6B66920E4FE82A66FF6C00F79245D83D4AFC0C2AA3436A1946AC35AD2286D2D46219CDD3084598C611D846130CD70",
                      "Connection": "keep-alive",
                      "cache-control": "no-cache"
                    ]

                    let request = NSMutableURLRequest(url: NSURL(string: "https://api-reg-apigee.ncrsilverlab.com/v2/inventory/items")! as URL,cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
                    request.httpMethod = "GET"
                    request.allHTTPHeaderFields = headers2
                    let session = URLSession.shared
                    let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                      if (error != nil) {
                        print(error)
                      } else {
                        let httpResponse = response as? HTTPURLResponse
                        if let dataUnwrapped = data {
                            do {
                            let json = try JSON(data: dataUnwrapped)
                            var foodItems = [FoodItem]()
                            for i in 0..<(json["Result"].count) {
                                let name = json["Result"][i]["Name"].string ?? ""
                                let price = json["Result"][i]["RetailPrice"].double
                                let itemCategoryName = json["Result"][i]["customAttributeSets"][1]["attributes"][0]["value"].string ?? ""
                                let externalItemId = json["Result"][i]["ItemVariations"][0]["ExternalItemId"].string ?? ""
                                foodItems.append(FoodItem(name: name, price: price ?? 0, itemCategoryName: itemCategoryName, externalItemId: externalItemId))
                            }
                            completion(foodItems)
                        } catch{
                            print("json unwrapping error")
                        }
                        }
                      }
                    })
                    dataTask.resume()
                } catch{
                    print("json unwrapping error")
                }
            }
          }
        })
        dataTask.resume()
}


func sendOrder(items: [FoodItem], restaurant: Restaurant, date: String, userName: String, partySize: Int) {
    let headers = [
        "Content-Type":"application/json",
        "Accept":"application/json",
        "Authorization":bearerToken
    ]
    var items2:[Any] = []
    for i in 0..<(items.count) {
        items2.append(["ExternalItemId": items[i].externalItemId, "ItemName":items[i].name, "Quantity":1, "UnitPrice":items[i].price, "UnitSellPrice":items[i].price, "ExtendedSellPrice":items[i].price])
        print(items2[0])
    }
    //let itemsFixedJson = JSON(itemsFixed)

    let json: [String:Any] =  ["Orders": [["IsClosed": true,"OrderDateTime": date,"OrderDueDateTime": date,"IsPaid": true,"Customer": ["CustomerId": 0,"CustomerName": userName,"Email": "abcde@email.com","PhoneNumber": "6782235758","Address1": "Address1","Address2": "string","Address3": "string","City": "string","State": "string","ZipCode": "string"],"CustomerId": 0,"CustomerName": userName,"TableReference": userName,"TaxAmount": 0,"TipAmount": 0,"LineItems": items2,"Notes": ["Dyne In\nParty Size: \(partySize)"],"KitchenLeadTimeInMinutes": 0,"SkipReceipt": true,"SkipKitchen": true]],"SourceApplicationName": "app"]
    print(JSONSerialization.isValidJSONObject(json))
    
    
    let jsonData = try? JSONSerialization.data(withJSONObject: json)
    let url = URL(string: "https://api-reg-apigee.ncrsilverlab.com/v2/orders?store_number=1")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.allHTTPHeaderFields = headers
    request.httpBody = jsonData
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data, error == nil else {
            print(error?.localizedDescription ?? "No data")
            return
        }
        let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
        if let responseJSON = responseJSON as? [String: Any] {
            print(responseJSON)
        }
    }
    task.resume()
}
