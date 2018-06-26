//
//  Helpers+Constants.swift
//  STRVWeather
//
//  Created by yusuf_kildan on 26.06.2018.
//  Copyright © 2018 yusuf_kildan. All rights reserved.
//

import UIKit

enum AssetType {
    case big
    case small
}

class Helpers {
    
    // MARK: - Functions
    
    class func windDirectionFromDegrees(degrees: Float) -> String {
        
        let directions = ["N", "NNE", "NE", "ENE", "E", "ESE", "SE", "SSE",
                          "S", "SSW", "SW", "WSW", "W", "WNW", "NW", "NNW"]
        
        let index = Int((degrees + 11.25) / 22.5)
        
        return directions[index % 16]
    }
    
    class func celsiusFromKelvin(kelvin: Double) -> Int {
        return Int(round(kelvin - 273.0))
    }
    
    class func assetFromIconName(iconName: String, isBig: Bool) -> UIImage {
        let weatherImageDict = [
            "01d" : "Day/ClearSky",
            "01n" : "Night/ClearSky",
            
            "02d" : "Day/FewClouds",
            "02n" : "Night/FewClouds",
            
            "03d" : "Day/ScatteredClouds",
            "03n" : "Night/ScatteredClouds",
            
            "04d" : "Day/BrokenClouds",
            "04n" : "Night/BrokenClouds",
            
            "09d" : "Day/ShowerRain",
            "09n" : "Night/ShowerRain",
            
            "10d" : "Day/Rain",
            "10n" : "Night/Rain",
            
            "11d" : "Day/Thunderstorm",
            "11n" : "Night/Thunderstorm",
            
            "13d" : "Day/Snow",
            "13n" : "Night/Snow",
            
            "50d" : "Day/Mist",
            "50n" : "Night/Mist"
        ]
        
        var assetName = weatherImageDict[iconName]!
        
        if isBig {
            assetName = assetName + "Big"
        }
        
        return UIImage(named: assetName)!
    }
}
