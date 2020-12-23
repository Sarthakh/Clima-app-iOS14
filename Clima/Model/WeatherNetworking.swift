//
//  WeatherNetworking.swift
//  Clima
//
//  Created by Sarthak Khillan on 10/12/20.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func temperatureDidUpdate(_ weatherNetworking: WeatherNetworking , weather: WeatherModel)
    func errorDidOccur(error: Error)
}

class WeatherNetworking {
    var delegate: WeatherManagerDelegate?
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=5e9a8e221da0ffdfeec7d3ee33546340&units=metric"
    func fetchWeather(cityName: String){
        let weatherString = "\(weatherURL)&q=\(cityName)"
        performWeather(weatherString)
    }
    
    func performWeather(_ urlString: String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in        //Trailing Closure -> very useful for inline funtion things
                if error != nil{
                    self.delegate?.errorDidOccur(error: error!)
                    return
                }
                if let safeData = data{
                    if let weather = self.parseJSON(safeData){
                        self.delegate?.temperatureDidUpdate(self, weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ safeData: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do{
            let decodeData = try decoder.decode(WeatherData.self, from: safeData) //we use self to refer to the datatype of the struct/class
            let weatherModel = WeatherModel(cityTemp: decodeData.main.temp, cityName:  decodeData.name, cityWeatherID: decodeData.weather[0].id)
            return weatherModel
        } catch{
            self.delegate?.errorDidOccur(error: error)
            return nil
        }
        
    }
    
    func fetchWeather(longitude lon: CLLocationDegrees , latitude lat: CLLocationDegrees){
        let weatherString = "\(weatherURL)&lon=\(lon)&lat=\(lat)"
        performWeather(weatherString)
    }
}
