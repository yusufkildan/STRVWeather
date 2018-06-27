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
        
        LocationManager.sharedManager.requestCurrentLocation { (location, error) in
            if let error = error {
                self.finishLoading(withState: ControllerState.error,
                                   andMessage: error.localizedDescription)
                
                return
            }
            
            guard let location = location else {
                return
            }
            
            NetworkClient.sharedClient.getFiveDayForecast(forLocation: location, completion: { (dailyForecasts, error) in
                if let error = error {
                    self.finishLoading(withState: ControllerState.error,
                                       andMessage: error.localizedDescription)
                    
                    return
                }
                
                guard let dailyForecasts = dailyForecasts else {
                    return
                }
                
                self.dailyForecasts = dailyForecasts
                
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
        
        if let weatherDescription = forecast.weatherDescription {
            cell.weatherDescription = weatherDescription.capitalized
        }
        
        if let temperature = forecast.temperature {
            cell.temperature = "\(temperature)°"
        }
        
        if let date = forecast.date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            
            cell.time = dateFormatter.string(from: date)
        }
        
        if let cityName = forecast.city {
            self.navigationItem.title = cityName
        }
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? ForecastTableViewCell else {
            return
        }
        
        cell.layer.transform = CATransform3DMakeScale(0.5, 0.5, 0.5)
        
        UIView.animate(withDuration: 0.3, animations: {
            cell.layer.transform = CATransform3DIdentity
        }, completion: nil)
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
