//
//  ForecastTableViewController.swift
//  STRVWeather
//
//  Created by yusuf_kildan on 26.06.2018.
//  Copyright © 2018 yusuf_kildan. All rights reserved.
//

import UIKit

class ForecastTableViewController: BaseTableViewController {
    
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
        self.navigationItem.title = "Forecast"
    }
    
    // MARK: - View's Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
