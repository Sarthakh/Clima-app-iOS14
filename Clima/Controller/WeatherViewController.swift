//
//  ViewController.swift
//  Clima
//
// Created by Sarthak Khillan on 09/12/20.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController{
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var textFieldOutlet: UITextField!
    let weatherModelVariable = WeatherNetworking()
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        weatherModelVariable.delegate = self
        textFieldOutlet.delegate = self
    }
}

//MARK: - UITEXTFIELD

extension WeatherViewController: UITextFieldDelegate{
    @IBAction func searchButtonIsPressed(_ sender: Any) {
        weatherModelVariable.fetchWeather(cityName: textFieldOutlet.text!)
        
    }
    
    @IBAction func gpsButtonIsPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        weatherModelVariable.fetchWeather(cityName: textFieldOutlet.text!)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        textFieldOutlet.text = textFieldOutlet.placeholder
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textFieldOutlet.text == " " {
            return false
        }else{
            return true
        }
    }
}


//MARK: - Weather Manager Stuff

extension WeatherViewController: WeatherManagerDelegate{
    func temperatureDidUpdate(_ weatherNetworking: WeatherNetworking, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.conditionImageView.image = UIImage(systemName: weather.cityWeatherCondition)
            self.cityLabel.text = weather.cityName
            self.temperatureLabel.text = weather.cityTempString
        }
    }
    func errorDidOccur(error: Error){
        print(error)
    }
}

//MARK: - CLLocationManagerDelegate


extension WeatherViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            locationManager.stopUpdatingLocation()
            let lon = location.coordinate.longitude
            let lat = location.coordinate.latitude
            weatherModelVariable.fetchWeather(longitude: lon, latitude: lat)
        }
    }
}
