//
//  WeatherModel.swift
//  Clima
//
//  Created by Gayathri Chelluri on 27/4/2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    var cityName: String
    var temperature: Double
    var conditionId: Int
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    var conditionName: String {
        switch conditionId {
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
    
    init(conditionId: Int, cityName: String, temp: Double) {
        self.conditionId = conditionId
        self.cityName = cityName
        self.temperature = temp
    }
}
