//
//  CurrentWeather.swift
//  STRVWeather
//
//  Created by yusuf_kildan on 26.06.2018.
//  Copyright © 2018 yusuf_kildan. All rights reserved.
//

import UIKit
import SwiftyJSON

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
        temperature            = Helpers.celsiusFromKelvin(kelvin: json["main"]["temp"].doubleValue)
        weatherImage           = Helpers.assetFromIconName(iconName: json["weather"][0]["icon"].stringValue, isBig: true)
        weatherDescription     = json["weather"][0]["description"].stringValue
        humidity               = json["main"]["humidity"].intValue
        precipitation          = json["clouds"]["all"].doubleValue
        pressure               = json["main"]["pressure"].intValue
        wind                   = json["wind"]["speed"].doubleValue
        windDirection          = Helpers.windDirectionFromDegrees(degrees: json["wind"]["deg"].floatValue)
    }
}
