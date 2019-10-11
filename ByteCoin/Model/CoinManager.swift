//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol CoinManagerDelegate {
    func didUodatePrice(price: String, currency: String)
    func didFailWithError(error: Error)
}

struct CoinManager {
    var delegate:CoinManagerDelegate?
    
    let baseURL = "https://blockchain.info/ticker"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","INR","JPY","NZD","PLN","RUB","SEK","SGD","USD", "CHF", "CLP", "DKK", "ISK", "KRW", "THB", "TWD"]
    
    func getCoinPrice (_ currency: String)  {
        
        Alamofire.request(baseURL, method: .get).responseJSON{
            response in
            if response.result.isSuccess{
                let currencyJSON: JSON = JSON(response.result.value!)
                parseJSON(currencyJSON, curr: currency)
                print(response.result.value!)
            } else{
                self.delegate?.didFailWithError(error: response.result.error!)
            }
        }
        
        func parseJSON(_ data: JSON, curr: String)  {
            if let currency = data[currency]["last"].double {
                self.delegate?.didUodatePrice(price: "\(currency)", currency: curr)
            } else{
                self.delegate?.didUodatePrice(price: "Sorry", currency: "Please")
            }
        }
    }
}
