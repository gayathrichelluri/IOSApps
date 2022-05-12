//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didGetCoinPrice(_ price: String, _ currency: String)
    func didFailWithError(error: Error)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "E937E740-1872-49E5-A645-A7BA07542DDD"
    var delegate: CoinManagerDelegate?
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    func getCoinPrice(for currency: String) {
        let url = "\(baseURL)/\(currency)"
        performRequest(with: url, for: currency)
    }
    
    func performRequest(with url: String, for currency: String) {
        if let urlString = URL(string: url) {
            var request = URLRequest(url: urlString)
            request.setValue(apiKey, forHTTPHeaderField: "X-CoinAPI-Key")
            
            URLSession.shared.dataTask(with: request) {
                (data, response, error) in
                    if error != nil {
                        print("error ---- ", error!)
                        delegate?.didFailWithError(error: error!)
                        return
                    }
                    
                    if let safeData = data {
                        if let lastPrice = parseJSON(data: safeData) {
                            delegate?.didGetCoinPrice(String(format: "%.2f", lastPrice), currency)
                        }
                    }
            }.resume()
        }
        
    }
    
    func parseJSON(data: Data) -> Double? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: data)
            return decodedData.rate
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
        
}
