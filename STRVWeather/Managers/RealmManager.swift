//
//  RealmManager.swift
//  STRVWeather
//
//  Created by yusuf_kildan on 27.06.2018.
//  Copyright © 2018 yusuf_kildan. All rights reserved.
//

import Foundation
import RealmSwift

class RealmManager {
    
    static let sharedManager = RealmManager()
    
    // MARK: - Create Realm
    
    fileprivate func realm() -> Realm {
        do {
            let realm = try Realm()
            
            return realm
        } catch {
            log.error("Couldn't create application realm.")
            fatalError("[DEV ERROR] Failed to create application realm.")
        }
    }
    
    // MARK: - Current Weather
    
    func saveCurrentWeather(weather: CurrentWeather) {
        deleteCurrentWeather()
        
        do {
            try realm().write {
                realm().add(weather)
            }
        } catch {
            log.error("Realm writing error: \(error)")
        }
    }
    
    func getCurrentWeather() -> CurrentWeather? {
        return realm().objects(CurrentWeather.self).first
    }
    
    func deleteCurrentWeather()  {
        do {
            try realm().write {
                realm().delete(realm().objects(CurrentWeather.self))
            }
        } catch {
            log.error("Realm deleting error: \(error)")
        }
    }
    
    // MARK: - Five Day Forecast
    
    func saveFiveDayForecast(forecasts: [Forecast]) {
        deleteFiveDayForecast()
        
        do {
            try realm().write {
                realm().add(forecasts)
            }
        } catch {
            log.error("Realm writing error: \(error)")
        }
    }
    
    func getFiveDayForecast() -> Results<Forecast> {
        return realm().objects(Forecast.self)
    }
    
    func deleteFiveDayForecast()  {
        do {
            try realm().write {
                realm().delete(realm().objects(Forecast.self))
            }
        } catch {
            log.error("Realm writing error: \(error)")
        }
    }
}
