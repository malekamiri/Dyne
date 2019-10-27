//
//  File.swift
//  dyneDummy
//
//  Created by Marcelo Costa on 10/26/19.
//  Copyright © 2019 Marcelo Costa. All rights reserved.
//

import Foundation
import SwiftyJSON

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

func test() {
    let request = NSMutableURLRequest(url: NSURL(string: "https://gateway-staging.ncrcloud.com/site/sites/find-nearby/29.25,92?radius=1000000000&numSites=10&customAttributes=CREDENTIALS")! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
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
                    for i in 0..<json["sites"].count {
                        print(json["sites"][i]["siteName"])
                    }
                } catch {
                    print("json unwrapping error")
                }
            }
        }
    }


    dataTask.resume()
}

func getNearbyRestaurants(completion: @escaping ([Restaurant]) -> ()) {
    let request = NSMutableURLRequest(url: NSURL(string: "https://gateway-staging.ncrcloud.com/site/sites/find-nearby/29.25,92?radius=1000000000&numSites=10&customAttributes=CREDENTIALS&customAttributes=IMAGE")! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
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
                        
                        print(json["sites"][i])
                        let name = json["sites"][i]["siteName"].string ?? ""
                        var location = json["sites"][i]["address"]["street"].string ?? ""
                        location += json["sites"][i]["address"]["city"].string ?? ""
                        location += ", "
                        location += json["sites"][i]["address"]["state"].string ?? ""
                        location += ", "
                        location += json["sites"][i]["address"]["postalCode"].string ?? ""
                        let openHour = 9
                        let closeHour = 12
                        let rating = 0
                        let wait = 20
                        let clientId = json["sites"][i]["customAttributeSets"][1]["attributes"][0]["value"].string ?? ""
                        let clientSecret = json["sites"][i]["customAttributeSets"][1]["attributes"][1]["value"].string ?? ""
                        var imageLink = json["sites"][i]["customAttributeSets"][0]["attributes"][0]["value"].string ?? ""
                        
                        //imageLink = imageLink.replacingOccurrences(of: "\\", with: "/")
                        restaurants.append(Restaurant(name: name, location: location, openHour: openHour, closeHour: closeHour, wait: wait, clientId: clientId, clientSecret: clientSecret, imageLink: imageLink))
                        
            
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
