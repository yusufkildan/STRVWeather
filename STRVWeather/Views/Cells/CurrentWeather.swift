//
//  CurrentWeather.swift
//  STRVWeather
//
//  Created by yusuf_kildan on 26.06.2018.
//  Copyright © 2018 yusuf_kildan. All rights reserved.
//

import UIKit
import SwiftyJSON

fileprivate let WeatherImageDict = [
    "01d" : "Day/ClearSkyBig",
    "01n" : "Night/ClearSkyBig",
    
    "02d" : "Day/FewCloudsBig",
    "02n" : "Night/FewCloudsBig",
    
    "03d" : "Day/ScatteredCloudsBig",
    "03n" : "Night/ScatteredCloudsBig",
    
    "04d" : "Day/BrokenCloudsBig",
    "04n" : "Night/BrokenCloudsBig",
    
    "09d" : "Day/ShowerRainBig",
    "09n" : "Night/ShowerRainBig",
    
    "10d" : "Day/RainBig",
    "10n" : "Night/RainBig",
    
    "11d" : "Day/ThunderstormBig",
    "11n" : "Night/ThunderstormBig",
    
    "13d" : "Day/SnowBig",
    "13n" : "Night/SnowBig",
    
    "50d" : "Day/MistBig",
    "50n" : "Night/MistBig"
]

class CurrentWeather {
    var city: String!
    var country: String!
    var temperature: Int!
    var weatherDescription: String!
    var humidity: Int!
    var precipitation: Double!
    var pressure: Int!
    var wind: Double!
    var windDirection: String!
    var weatherImage: UIImage!

    // MARK: - Constructors
    
    init(withJSON json: JSON) {
        city                   = json["name"].stringValue
        country                = json["sys"]["country"].stringValue
        temperature            = celsiusFromKelvin(kelvin: json["main"]["temp"].doubleValue)
        weatherImage           = assetFromIconName(iconName: json["weather"][0]["icon"].stringValue)
        weatherDescription     = json["weather"][0]["description"].stringValue
        humidity               = json["main"]["humidity"].intValue
        precipitation          = json["clouds"]["all"].doubleValue
        pressure               = json["main"]["pressure"].intValue
        wind                   = json["wind"]["speed"].doubleValue
        windDirection          = windDirectionFromDegrees(degrees: json["wind"]["deg"].floatValue)
    }
    
    // MARK: - Helpers
    
    fileprivate func windDirectionFromDegrees(degrees: Float) -> String {
        
        let directions = ["N", "NNE", "NE", "ENE", "E", "ESE", "SE", "SSE",
                          "S", "SSW", "SW", "WSW", "W", "WNW", "NW", "NNW"]
        
        let index = Int((degrees + 11.25)/22.5)
        
        return directions[index % 16]
    }
    
    fileprivate func celsiusFromKelvin(kelvin: Double) -> Int {
        return Int(round(kelvin - 273))
    }
    
    fileprivate func assetFromIconName(iconName: String) -> UIImage {
        return UIImage(named: WeatherImageDict[iconName]!)!
    }
}
