//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func lastBtcPrice(bitcoinData: CryptoModel)
    func didFailWithError(_ error: Error)
}

struct CoinManager {
    
    var delegate: CoinManagerDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "42132585-AE41-45EE-8645-6C77E73E101F"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getCoinPrice(for currency: String) {
        let url = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        performRequest(urlString: url)
    }
    
    func performRequest(urlString: String){
        //      1. Create URL
        if let url = URL(string: urlString) {
            //      2. Create URL Session
            let session = URLSession(configuration: .default)
            //      3. Give the session a task
            let task = session.dataTask(with: url, completionHandler: handle(data: response: error: ))
            //      4. Start the task
            task.resume()
        }
    }
    
    func handle(data: Data?, response: URLResponse?, error: Error?) {
        if error != nil {
            delegate?.didFailWithError(error!)
        }
        if let safeData = data {
            if let parsedData = parseJSON(safeData) {
                delegate?.lastBtcPrice(bitcoinData: parsedData)
            }
        }
    }
    
    func parseJSON(_ data: Data) -> CryptoModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CryptoData.self, from: data)
            return CryptoModel(baseCryptocoin: decodedData.asset_id_base, selectedCurrency: decodedData.asset_id_quote, currencyRate: decodedData.rate)
        } catch {
            delegate?.didFailWithError(error)
            return nil
        }
    }
}
