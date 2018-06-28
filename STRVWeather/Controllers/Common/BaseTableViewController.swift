//
//  BaseTableViewController.swift
//  STRVWeather
//
//  Created by yusuf_kildan on 26.06.2018.
//  Copyright © 2018 yusuf_kildan. All rights reserved.
//

import UIKit
import PureLayout

class BaseTableViewController: BaseViewController {
    var tableView: UITableView! = UITableView()
    
    fileprivate lazy var refreshControl: UIRefreshControl! = {
        [unowned self] in
        
        return UIRefreshControl()
        }()
    
    var contentInset: UIEdgeInsets! {
        get {
            return tableView.contentInset
        }
        
        set (newValue) {
            tableView.contentInset = newValue
        }
    }
    
    var scrollIndicatorInsets: UIEdgeInsets! {
        didSet {
            tableView.scrollIndicatorInsets = scrollIndicatorInsets
        }
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: CGRect.zero)
        tableView.backgroundColor = UIColor.primaryBackgroundColor()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.keyboardDismissMode = UIScrollViewKeyboardDismissMode.interactive
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.separatorColor = UIColor.listSeparatorColor()
        
        view.addSubview(tableView)
        
        tableView.autoPinEdgesToSuperviewEdges()
        
        
        if canPullToRefresh() {
            refreshControl.addTarget(self,
                                     action: #selector(refresh(_:)),
                                     for: UIControlEvents.valueChanged)
            
            tableView.addSubview(refreshControl)
        }
    }
    
    // MARK: - Refresh
    
    func canPullToRefresh() -> Bool {
        return false
    }
    
    @objc fileprivate func refresh(_ refreshControl: UIRefreshControl) {
        _ = loadData(withRefresh: true)
    }
    
    func endRefreshing() {
        guard let refreshControl = refreshControl else {
            return
        }
        
        refreshControl.endRefreshing()
    }
}

// MARK: - UITableViewDelegate

extension BaseTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

// MARK: - UITableViewDataSource

extension BaseTableViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
