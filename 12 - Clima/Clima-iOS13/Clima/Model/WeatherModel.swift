//
//  WeatherModel.swift
//  Clima
//
//  Created by Joao Pedro da Mata Gonçalves Ribeiro on 22/06/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    let cityName: String
    let temperature: Double
    let conditionID: Int
    
    var tempString: String {
        return String(format: "%.1f", temperature)
    }
    
    var description: String {
        switch conditionID {
        case 200...232:
            return "cloud.bolt.rain"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud"
        default:
            return "cloud.bolt"
        }
    }
}
