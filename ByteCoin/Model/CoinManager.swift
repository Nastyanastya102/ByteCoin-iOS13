//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

struct CoinData: Codable {
    let asset_id_base: String
    let rates: [Rate]
}

struct Rate: Codable {
    let asset_id_quote: String
    let rate: Double
}


struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = ""
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    func getCurrPrice (_ curr: String) {
        perfomeRequest(with: baseURL + "?apikey=" + apiKey)
    }
    
    func parseJSON(_ data: Data) -> Double? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: data)
            let last = decodedData.rates.first?.rate
            
            return last
        } catch {
            return nil
        }
    }

    func perfomeRequest (with url: String) {
        if let url = URL(string: url) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) {
                (data, responce, error) in
                if error != nil {
                    return
                }
                
                if let selfData = data {
                    print(String(data: selfData, encoding: .utf8)!)
                    print(parseJSON(selfData)!)
                }
                
            }
            
            task.resume()
        }
    }
    
    
}
