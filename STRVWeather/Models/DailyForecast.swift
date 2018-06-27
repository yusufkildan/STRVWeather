//
//  DailyForecast.swift
//  STRVWeather
//
//  Created by yusuf_kildan on 26.06.2018.
//  Copyright © 2018 yusuf_kildan. All rights reserved.
//

import UIKit
import SwiftyJSON

class Forecast {
    var city: String!
    var temperature: Int!
    var weatherDescription: String!
    var weatherImage: UIImage!
    var date: Date!
    
    // MARK: - Constructors
    
    init(withJSON json: JSON, andCityName cityName: String) {
        city                   = cityName
        temperature            = Helpers.celsiusFromKelvin(kelvin: json["main"]["temp"].doubleValue)
        weatherDescription     = json["weather"][0]["description"].stringValue
        date                   = Date(timeIntervalSince1970: json["dt"].doubleValue)
        weatherImage           = Helpers.assetFromIconName(iconName: json["weather"][0]["icon"].stringValue, isBig: false)
    }
}

class DailyForecast {
    let dayIdentifier: DayIdentifier
    let forecasts: [Forecast]
    
    // MARK: - Constructors
    
    init(dayIdentifier: DayIdentifier, forecasts: [Forecast]) {
        self.dayIdentifier = dayIdentifier
        self.forecasts = forecasts
    }
    
    // MARK: - Group Forecasts
    
    static func groupForecasts(forecasts: [Forecast]) -> [DailyForecast] {
        
        guard !forecasts.isEmpty else {
            return []
        }
        
        let calendar = Calendar.current
        var grouped: [DayIdentifier: [Forecast]] = [:]
        
        for forecast in forecasts {
            guard let forecastDate = forecast.date else {
                continue
            }
            
            let components = calendar.dateComponents([.year, .month, .day], from: forecastDate)
            
            let dayIdentifier = DayIdentifier.fromComponents(components: components)
            
            var forecasts = grouped[dayIdentifier] ?? [Forecast]()
            forecasts.append(forecast)
            
            grouped[dayIdentifier] = forecasts
        }
        
        var dailyForecasts: [DailyForecast] = []
        
        for (dayIdentifier, forecasts) in grouped {
            let sortedForecasts = forecasts.sorted {
                $0.date! < $1.date!
            }
            
            let dailyForecast = DailyForecast(dayIdentifier: dayIdentifier, forecasts: sortedForecasts)
            dailyForecasts.append(dailyForecast)
        }
        
        return dailyForecasts.sorted { $0.dayIdentifier < $1.dayIdentifier }
    }
}
