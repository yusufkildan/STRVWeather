//
//  ForecastTableViewController.swift
//  STRVWeather
//
//  Created by yusuf_kildan on 26.06.2018.
//  Copyright © 2018 yusuf_kildan. All rights reserved.
//

import UIKit

class ForecastTableViewController: BaseTableViewController {
    
    fileprivate var dailyForecasts: [DailyForecast] = []
    
    // MARK: - Constructors
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    override init() {
        super.init()
        
        commonInit()
    }
    
    fileprivate func commonInit() {
        title = "Forecast"
    }
    
    // MARK: - View's Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(ForecastTableViewCell.classForCoder(),
                           forCellReuseIdentifier: ForecastTableViewCellReuseIdentifier)
        tableView.register(ForecastTableViewHeaderView.classForCoder(),
                           forHeaderFooterViewReuseIdentifier: ForecastTableViewHeaderViewReuseIdentifier)
        
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.separatorColor = UIColor.listSeparatorColor()
        tableView.separatorInset = UIEdgeInsets(top: 0.0, left: 104.0, bottom: 0.0, right: 0.0)
        tableView.backgroundView = UIView()
        
        // Get persisted data from Realm Database
        let forecastArray = Array(RealmManager.sharedManager.getFiveDayForecast())
        self.dailyForecasts = DailyForecast.groupForecasts(forecasts: forecastArray)
        
        loadData(withRefresh: true)
    }
    
    // MARK: - Interface
    
    override func canPullToRefresh() -> Bool {
        return true
    }
    
    // MARK: - Load Data
    
    @discardableResult override func loadData(withRefresh refresh: Bool) -> Bool {
        if !super.loadData(withRefresh: refresh) {
            return false
        }
        
        log.debug("Request current location.")
        LocationManager.sharedManager.requestCurrentLocation { (location, error) in
            if let error = error {
                log.error("Location request failed: \(error.localizedDescription)")
                
                self.finishLoading(withState: ControllerState.error,
                                   andMessage: error.localizedDescription)
                
                return
            }
            
            guard let location = location else {
                return
            }
            
            log.debug("Location request success: \(location)")
            
            log.debug("Request five day forecast.")
            NetworkClient.sharedClient.getFiveDayForecast(forLocation: location, completion: { (forecasts, error) in
                if let error = error {
                    log.error("Five day forecast request failed: \(error.localizedDescription)")
                    
                    self.finishLoading(withState: ControllerState.error,
                                       andMessage: error.localizedDescription)
                    self.endRefreshing()
                    
                    return
                }
                
                guard let forecasts = forecasts else {
                    log.error("Error getting five day forecast.")
                    
                    return
                }
                
                // Save five day forecast to Realm Database
                RealmManager.sharedManager.saveFiveDayForecast(forecasts: forecasts)
                
                self.dailyForecasts = DailyForecast.groupForecasts(forecasts: forecasts)
                
                self.tableView.reloadData()
                self.finishLoading(withState: ControllerState.none, andMessage: nil)
                self.endRefreshing()
            })
        }
        
        return true
    }
    
    // MARK: - Configure
    
    fileprivate func configure(ForecastTableViewCell cell: ForecastTableViewCell, withIndexPath indexPath: IndexPath) {
        if indexPath.row >= dailyForecasts[indexPath.section].forecasts.count {
            return
        }
        
        let forecast = dailyForecasts[indexPath.section].forecasts[indexPath.row]
        
        cell.weatherImage = forecast.weatherImage
        cell.weatherDescription = forecast.weatherDescription.capitalized
        cell.temperature = "\(forecast.temperature)°"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        cell.time = dateFormatter.string(from: forecast.date)
        
        self.navigationItem.title = forecast.city
    }
    
    fileprivate func configure(ForecastTableViewHeaderView headerView: ForecastTableViewHeaderView, withSection section: Int) {
        if section >= dailyForecasts.count {
            return
        }
        
        let forecast = dailyForecasts[section].forecasts.first
        
        if let date = forecast?.date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE"
            
            headerView.title = dateFormatter.string(from: date)
        }
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return dailyForecasts.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dailyForecasts[section].forecasts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ForecastTableViewCellReuseIdentifier,
                                                 for: indexPath) as! ForecastTableViewCell
        
        configure(ForecastTableViewCell: cell, withIndexPath: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ForecastTableViewHeaderViewReuseIdentifier) as! ForecastTableViewHeaderView
        
        configure(ForecastTableViewHeaderView: headerView, withSection: section)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ForecastTableViewCell.cellHeight()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return ForecastTableViewHeaderView.headerHeight()
    }
}
