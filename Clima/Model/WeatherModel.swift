//
//  WeatherModel.swift
//  Clima
//
//  Created by Sarthak Khillan on 04/12/20.
//

import Foundation

struct WeatherModel {
    let cityTemp: Double
    let cityName: String
    let cityWeatherID: Int
    
    //derived field in the struct, can be used to incorporate conditionals easily into the struct without implemnenting a function
    
    var cityWeatherCondition: String{
        switch cityWeatherID {
        case 200...232:
            return "cloud.bolt"
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
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
    
    var cityTempString: String{
        return String(format: "%.0f", cityTemp)
    }
}
