//
//  WeatherData.swift
//  Clima
//
//  Created by Sarthak Khillan on 09/12/20.
//

import UIKit

struct WeatherData: Decodable{
    var name: String
    var main: Main
    var weather: [Weather]
}

struct Main: Decodable{
    var temp: Double
}

struct Weather: Decodable{
    let id: Int
}
