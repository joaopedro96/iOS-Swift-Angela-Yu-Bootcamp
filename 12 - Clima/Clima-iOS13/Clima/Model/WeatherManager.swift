//
//  WeatherManager.swift
//  Clima
//
//  Created by Joao Pedro da Mata Gonçalves Ribeiro on 21/06/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import UIKit


protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(_ error: Error)
}

struct WeatherManager {
    
    var delegate: WeatherManagerDelegate?
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=1db61ca465eaad062426219d57b2afa1&units=metric"
    
    func fetchWeather(_ cityName: String) {
        let urlString: String = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func fetchWeather(latitude: Double, longitude: Double) {
        let urlString: String = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        //1. Create URL
        if let url = URL(string: urlString) {
            //2. Create URL Session
            let session = URLSession(configuration: .default)
            //3. Give the session a task
            let task = session.dataTask(with: url, completionHandler: handle(data: response: error: ))
            //4. Start the task
            task.resume()
            
        }
    }
  
    func handle(data: Data?, response: URLResponse?, error: Error?){
        if error != nil {
            delegate?.didFailWithError(error!)
            return
        }
        if let safeWeatherData = data {
            if let parsedWeather = parseJSON(safeWeatherData) {
                delegate?.didUpdateWeather(self, weather: parsedWeather)
            }
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
           
            let name = decodedData.name
            let temp = decodedData.main.temp
            let id = decodedData.weather[0].id
            let weather = WeatherModel(cityName: name, temperature: temp, conditionID: id)
            return weather
            
        } catch {
            delegate?.didFailWithError(error)
            return nil
        }
    }
}


//            CONVERSAO DO DADO DE ENTRADA PARA STRING
//if let safeData = data {
//            let dataString = String(data: safeData, encoding: .utf8)
//            print(dataString)
//}
