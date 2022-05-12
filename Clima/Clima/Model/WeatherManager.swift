//
//  WeatherManager.swift
//  Clima
//
//  Created by Gayathri Chelluri on 27/4/2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ data: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=6a1cadfdba4d4e067c54721d0acbea5f&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    func performRequest(with url: String) {
        // 1. Create a URL
        if let urlString = URL(string: url) {
            
            // 2. Create a URLSession
            let session = URLSession(configuration: .default)
            
            // 3. Give the session a task
            let task = session.dataTask(with: urlString) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let parsedData = parseJSON(safeData) {
                        print("parsedData: ", parsedData)
                        self.delegate?.didUpdateWeather(parsedData)
                    }
                    
                }
            }
            
            // 4. Start the task
            task.resume()
            
        }
    }
    
    
    
    func parseJSON(_ data: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: data)
            let conditionId = decodedData.weather[0].id
            let cityName = decodedData.name
            let temp = decodedData.main.temp
            
            let weather = WeatherModel(conditionId: conditionId, cityName: cityName, temp: temp)
            return weather
        } catch {
            self.delegate?.didFailWithError(error: error)
            return nil
        }
        
    }
    
}
