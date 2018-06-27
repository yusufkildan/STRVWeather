//
//  DailyForecast.swift
//  STRVWeather
//
//  Created by yusuf_kildan on 26.06.2018.
//  Copyright © 2018 yusuf_kildan. All rights reserved.
//

import UIKit
import SwiftyJSON
import RealmSwift

class Forecast: Object {
    @objc dynamic var city: String = ""
    @objc dynamic var temperature: Int = 0
    @objc dynamic var weatherDescription: String = ""
    @objc dynamic var iconName: String = ""
    @objc dynamic var date: Date = Date()
    
    var weatherImage: UIImage {
        return Helpers.assetFromIconName(iconName: iconName, isBig: false)
    }
    
    // MARK: - Constructors
    
    convenience init(withJSON json: JSON, andCityName cityName: String) {
        self.init()
        city                   = cityName
        temperature            = Helpers.celsiusFromKelvin(kelvin: json["main"]["temp"].doubleValue)
        weatherDescription     = json["weather"][0]["description"].stringValue
        date                   = Date(timeIntervalSince1970: json["dt"].doubleValue)
        iconName               = json["weather"][0]["icon"].stringValue
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
            let components = calendar.dateComponents([.year, .month, .day], from: forecast.date)
            
            let dayIdentifier = DayIdentifier.fromComponents(components: components)
            
            var forecasts = grouped[dayIdentifier] ?? [Forecast]()
            forecasts.append(forecast)
            
            grouped[dayIdentifier] = forecasts
        }
        
        var dailyForecasts: [DailyForecast] = []
        
        for (dayIdentifier, forecasts) in grouped {
            let sortedForecasts = forecasts.sorted {
                $0.date < $1.date
            }
            
            let dailyForecast = DailyForecast(dayIdentifier: dayIdentifier, forecasts: sortedForecasts)
            dailyForecasts.append(dailyForecast)
        }
        
        return dailyForecasts.sorted { $0.dayIdentifier < $1.dayIdentifier }
    }
}
