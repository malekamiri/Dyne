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
