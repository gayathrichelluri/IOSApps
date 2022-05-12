//
//  WeatherData.swift
//  Clima
//
//  Created by Gayathri Chelluri on 27/4/2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    var name: String
    var main: Main
    var weather: [Weather]
}

struct Main: Decodable {
    var temp: Double
}

struct Weather: Decodable {
    var id: Int
    var description: String
}
