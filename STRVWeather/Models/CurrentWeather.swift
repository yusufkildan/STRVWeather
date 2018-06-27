//
//  CurrentWeather.swift
//  STRVWeather
//
//  Created by yusuf_kildan on 26.06.2018.
//  Copyright © 2018 yusuf_kildan. All rights reserved.
//

import UIKit
import SwiftyJSON
import RealmSwift

class CurrentWeather: Object {
    @objc dynamic var city: String = ""
    @objc dynamic var country: String = ""
    @objc dynamic var temperature: Int = 0
    @objc dynamic var weatherDescription: String = ""
    @objc dynamic var humidity: Int = 0
    @objc dynamic var precipitation: Double = 0.0
    @objc dynamic var pressure: Int = 0
    @objc dynamic var wind: Double = 0.0
    @objc dynamic var windDirection: String = ""
    @objc dynamic var iconName: String = ""

    var weatherImage: UIImage! {
        return Helpers.assetFromIconName(iconName: iconName, isBig: true)
    }
    
    // MARK: - Constructors
    
    convenience init(withJSON json: JSON) {
        self.init()
        city                   = json["name"].stringValue
        country                = json["sys"]["country"].stringValue
        temperature            = Helpers.celsiusFromKelvin(kelvin: json["main"]["temp"].doubleValue)
        iconName               = json["weather"][0]["icon"].stringValue
        weatherDescription     = json["weather"][0]["description"].stringValue
        humidity               = json["main"]["humidity"].intValue
        precipitation          = json["clouds"]["all"].doubleValue
        pressure               = json["main"]["pressure"].intValue
        wind                   = json["wind"]["speed"].doubleValue
        windDirection          = Helpers.windDirectionFromDegrees(degrees: json["wind"]["deg"].floatValue)
    }
}
