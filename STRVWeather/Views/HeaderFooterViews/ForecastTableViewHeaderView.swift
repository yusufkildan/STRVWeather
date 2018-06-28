//
//  ForecastTableViewHeaderView.swift
//  STRVWeather
//
//  Created by yusuf_kildan on 26.06.2018.
//  Copyright © 2018 yusuf_kildan. All rights reserved.
//

import UIKit
import PureLayout

let ForecastTableViewHeaderViewReuseIdentifier = NSStringFromClass(ForecastTableViewHeaderView.classForCoder())

class ForecastTableViewHeaderView: UITableViewHeaderFooterView {
    
    fileprivate var titleLabel: UILabel!
    
    var title: String! {
        didSet {
            self.titleLabel.text = title
        }
    }
    
    // MARK: - Constructors
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        commonInit()
    }
    
    fileprivate func commonInit() {
        let containerView = UIView.newAutoLayout()
        containerView.backgroundColor = UIColor.primaryBackgroundColor()
        
        contentView.addSubview(containerView)
        
        containerView.autoPinEdgesToSuperviewEdges()
        
        
        titleLabel = UILabel.newAutoLayout()
        titleLabel.textColor = UIColor.primaryDarkTextColor()
        titleLabel.font = UIFont.proximaNovaBoldFont(withSize: 14.0)
        
        containerView.addSubview(titleLabel)
        
        let insets = UIEdgeInsetsMake(0.0, 18.0, 0.0, 0.0)
        titleLabel.autoPinEdgesToSuperviewEdges(with: insets)
        
        
        let topSeparatorView = UIView.newAutoLayout()
        topSeparatorView.backgroundColor = UIColor.listSeparatorColor()
        
        containerView.addSubview(topSeparatorView)
        
        topSeparatorView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero,
                                                      excludingEdge: ALEdge.bottom)
        topSeparatorView.autoSetDimension(ALDimension.height,
                                          toSize: 1.0)
        
        
        let bottomSeparatorView = UIView.newAutoLayout()
        bottomSeparatorView.backgroundColor = UIColor.listSeparatorColor()
        
        containerView.addSubview(bottomSeparatorView)
        
        bottomSeparatorView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero,
                                                         excludingEdge: ALEdge.top)
        bottomSeparatorView.autoSetDimension(ALDimension.height,
                                             toSize: 1.0)
    }
    
    // MARK: - Header Height
    
    class func headerHeight() -> CGFloat {
        return 45.0
    }
}
