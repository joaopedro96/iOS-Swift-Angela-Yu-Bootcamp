//
//  WeatherManager.swift
//  Clima
//
//  Created by Joao Pedro da Mata Gonçalves Ribeiro on 24/06/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeatherData(weatherData: WeatherModel)
}

struct WeatherManager {
    
    var delegate: WeatherManagerDelegate?
    
    let urlString = "https://api.openweathermap.org/data/2.5/weather?appid=1db61ca465eaad062426219d57b2afa1&units=metric"
    
    func fetchWeather(cityName: String) {
        let url = "\(urlString)&q=\(cityName)"
        performRequest(with: url)
    }
    
    func fectchWeather(latitude: Double, longitude: Double) {
        let url = "\(urlString)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: url)
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
    
    func handle(data: Data?, response: URLResponse?, error: Error?) {
        if error != nil {
            print(error!)
        }
        if let safeData = data {
            if let parsedData = parseJSON(weatherData: safeData) {
                print(parsedData) //TODO
                delegate!.didUpdateWeatherData(weatherData: parsedData)
            }
        }
    }
    
    func parseJSON(weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            return WeatherModel(cityName: decodedData.name, conditionID: decodedData.weather[0].id, temperature: decodedData.main.temp)
        } catch {
            print(error)
            return nil
        }
        
    }
}
