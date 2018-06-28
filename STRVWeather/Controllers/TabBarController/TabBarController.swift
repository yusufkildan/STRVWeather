//
//  TabBarController.swift
//  STRVWeather
//
//  Created by yusuf_kildan on 26.06.2018.
//  Copyright © 2018 yusuf_kildan. All rights reserved.
//

import UIKit

fileprivate enum TabType {
    case today
    case forecast
    
    var selectedAsset: UIImage! {
        switch self {
        case .today:
            return UIImage(named: "TodayTabActive")!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        case .forecast:
            return UIImage(named: "ForecastTabActive")!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        }
    }
    
    var defaultAsset: UIImage! {
        switch self {
        case .today:
            return UIImage(named: "TodayTabInactive")!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        case .forecast:
            return UIImage(named: "ForecastTabInactive")!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        }
    }
}

class TabBarController: UITabBarController {
    
    // MARK: - Constructors
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        commonInit()
    }
    
    private func commonInit() {
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.primaryDarkTextColor()],
                                                         for: UIControlState.normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.secondaryDarkTextColor()],
                                                         for: UIControlState.selected)
    }
    
    // MARK: View's Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.isTranslucent = false
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage(named: "Divider")
        
        
        let todayViewController = TodayViewController()
        let todayNavigationController = BaseNavigationController(rootViewController: todayViewController)
        todayNavigationController.tabBarItem = UITabBarItem(title: "Today",
                                                            image: TabType.today.defaultAsset,
                                                            selectedImage: TabType.today.selectedAsset)
        
        let forecastViewController = ForecastTableViewController()
        let forecastNavigationController = BaseNavigationController(rootViewController: forecastViewController)
        forecastNavigationController.tabBarItem = UITabBarItem(title: "Forecast",
                                                               image: TabType.forecast.defaultAsset,
                                                               selectedImage: TabType.forecast.selectedAsset)
        
        viewControllers = [todayNavigationController, forecastNavigationController]
    }
}
