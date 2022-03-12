//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    
    var locationManager = CLLocationManager()
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextField.delegate = self
        weatherManager.delegate = self
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
}

extension WeatherViewController: UITextFieldDelegate {
    @IBAction func searchCity(_ sender: UIButton) {
        if searchTextField.text != nil {
            searchTextField.endEditing(true)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if searchTextField.text != nil {
            searchTextField.endEditing(true)
            return true
        } else {
            return false
        }
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if searchTextField.text != "" {
            return true
        } else {
            searchTextField.placeholder = "Type the city name here"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if searchTextField.text != "" {
            weatherManager.fetchWeather(cityName: searchTextField.text!)
        }
        searchTextField.placeholder = "Search"
    }
}

extension WeatherViewController: WeatherManagerDelegate {
    func didUpdateWeatherData(weatherData: WeatherModel) {
        DispatchQueue.main.async {
            let updatedWeather = weatherData
            self.conditionImageView.image = UIImage(systemName: updatedWeather.weatherDescription)
            self.temperatureLabel.text = updatedWeather.tempString
            self.cityLabel.text = updatedWeather.cityName
        }
    }
}

extension WeatherViewController: CLLocationManagerDelegate {
    @IBAction func locatePressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fectchWeather(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
