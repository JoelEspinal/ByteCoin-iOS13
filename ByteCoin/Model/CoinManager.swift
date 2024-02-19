//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey =  "YOUR_API_KEY_HERE"
    
    // GET https://rest.coinapi.io/v1/exchangerate/:asset_id_base/:asset_id_quote
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getCoinPrice(for currency: String) {
        let currencyURL = "\(baseURL)/\(currency)"
        performRequest(with: currencyURL)
    }
    
    func performRequest(with urlString: String) {
       var queryItems = [ URLQueryItem(name: "ApiKey", value: apiKey) ]
        var components = URLComponents(string: urlString)!
        components.queryItems = queryItems
        if let url = components.url {
            
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                print(response)
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    if let coinModel = parseJSON(safeData){
                        print(safeData)
                        print(coinModel)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ coinData: Data) -> CoinModel? {
        let decoder = JSONDecoder()
        
        do{
            let decodedData = try decoder.decode(CoinData.self, from: coinData)
            let currencyRate = decodedData.asset_id_base
            let coinModel = CoinModel(rate: currencyRate)
            print(coinModel)
            
            return coinModel
        } catch {
            return nil
        }
    }
}
