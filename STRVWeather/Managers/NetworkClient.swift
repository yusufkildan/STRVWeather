//
//  NetworkClient.swift
//  STRVWeather
//
//  Created by yusuf_kildan on 26.06.2018.
//  Copyright © 2018 yusuf_kildan. All rights reserved.
//

import Foundation
import Alamofire
import CoreLocation
import SwiftyJSON

fileprivate let APIKey               = "e86f277ef313b7554a37049b02d3224f"
fileprivate let APIBaseURL           = "https://api.openweathermap.org/data/2.5"
fileprivate let CurrentWeatherPath   = "/weather"
fileprivate let FiveDayForecastPath  = "/forecast"

class NetworkClient {
    
    var shouldShowLogs: Bool = true
    
    // MARK: - Shared Client
    
    static let sharedClient = NetworkClient()
    
    // MARK: - Perform Request
    
    func performRequest(forPath path: String,
                        usingMethod method: Alamofire.HTTPMethod = HTTPMethod.get,
                        andEncoding encoding: Alamofire.ParameterEncoding = URLEncoding.default,
                        withParameters parameters: [String: Any]?,
                        completion: @escaping (Data?, HTTPURLResponse?, NSError?) -> Void) {
        
        showApplicationNetworkActivityIndicator()
        
        Alamofire.request(APIBaseURL + path, method: method, parameters: parameters, encoding: encoding, headers: nil).response { (defaultDataResponse) in
            
            let data = defaultDataResponse.data
            let response = defaultDataResponse.response
            let error = defaultDataResponse.error
            
            if self.shouldShowLogs {
                log.debug(response as Any)
            }
            
            self.hideApplicationNetworkActivityIndicator()
            
            if error == nil {
                guard let localData = data else {
                    let inlineError = NSError.inlineErrorWithErrorCode(code: ErrorCode.invalidParameters)
                    
                    completion(nil, response, inlineError)
                    
                    return
                }
                
                if self.shouldShowLogs {
                    guard let dataString = String(data: localData, encoding: String.Encoding.utf8) else {
                        return
                    }
                    
                    log.debug(dataString)
                }
                
                completion(localData, response, nil)
            } else {
                completion(nil, response, error! as NSError)
            }
        }
    }
    
    // MARK: - Current Weather
    
    func getCurrentWeather(forLocation location: CLLocation, completion: @escaping (CurrentWeather?, NSError?) -> Void) {
        var parameters = [String: Any]()
        
        parameters["lat"]    = location.coordinate.latitude
        parameters["lon"]    = location.coordinate.longitude
        parameters["appid"]  = APIKey
        
        performRequest(forPath: CurrentWeatherPath, withParameters: parameters) { (data, response, error) in
            if let error = error {
                
                completion(nil, error)
                
                return
            }
            
            guard let data = data else {
                return
            }
            
            let json = JSON(data)
            let currentWeather = CurrentWeather(withJSON: json)
            
            completion(currentWeather, nil)
        }
    }
    
    // MARK: - Five Day Forecast
    
    func getFiveDayForecast(forLocation location: CLLocation, completion: @escaping ([Forecast]?, NSError?) -> Void) {
        var parameters = [String: Any]()
        
        parameters["lat"]    = location.coordinate.latitude
        parameters["lon"]    = location.coordinate.longitude
        parameters["appid"]  = APIKey
        
        performRequest(forPath: FiveDayForecastPath, withParameters: parameters) { (data, response, error) in
            if let error = error {
                
                completion(nil, error)
                
                return
            }
            
            guard let data = data else {
                return
            }
            
            let forecastListJSON = JSON(data)["list"].arrayValue
            let cityName = JSON(data)["city"]["name"].stringValue
            
            var forecasts = [Forecast]()
            
            for json in forecastListJSON {
                let forecast = Forecast(withJSON: json, andCityName: cityName)
                forecasts.append(forecast)
            }
            
            completion(forecasts, nil)
        }
    }
    
    // MARK: - Helpers
    
    fileprivate func showApplicationNetworkActivityIndicator() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    fileprivate func hideApplicationNetworkActivityIndicator() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}
