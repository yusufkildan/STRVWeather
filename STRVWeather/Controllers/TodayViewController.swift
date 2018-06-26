//
//  TodayViewController.swift
//  STRVWeather
//
//  Created by yusuf_kildan on 26.06.2018.
//  Copyright © 2018 yusuf_kildan. All rights reserved.
//

import UIKit
import PureLayout

class TodayViewController: BaseViewController {
    
    fileprivate let WeatherImageViewDimension: CGFloat = 100.0
    
    fileprivate var weatherImageView: UIImageView!
    fileprivate var locationLabel: AccessorizedLabelView!
    fileprivate var weatherDetailLabel: UILabel!
    fileprivate var humidityLabel: AccessorizedLabelView!
    fileprivate var precipitationLabel: AccessorizedLabelView!
    fileprivate var pressureLabel: AccessorizedLabelView!
    fileprivate var windLabel: AccessorizedLabelView!
    fileprivate var windDirectionLabel: AccessorizedLabelView!
    
    fileprivate var separatorViewWidth: CGFloat {
        return self.view.frame.width * 0.4
    }
    
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
        self.navigationItem.title = "Today"
    }
    
    // MARK: - View's Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        createUserInterface()
    }
    
    // MARK: - Interface
    
    fileprivate func createUserInterface() {
        weatherImageView = UIImageView.newAutoLayout()
        weatherImageView.autoSetDimensions(to: CGSize(width: WeatherImageViewDimension,
                                                      height: WeatherImageViewDimension))
        
        
        locationLabel = AccessorizedLabelView.newAutoLayout()
        locationLabel.title = "_"
        locationLabel.image = UIImage(named: "CurrentLocation")
        locationLabel.imagePosition = AccessoryImagePosition.left
        locationLabel.textColor = UIColor.primaryDarkTextColor()
        locationLabel.font = UIFont.proximaNovaSemiboldFont(withSize: 18.0)
        
        
        weatherDetailLabel = UILabel.newAutoLayout()
        weatherDetailLabel.text = "_"
        weatherDetailLabel.textColor = UIColor.secondaryDarkTextColor()
        weatherDetailLabel.font = UIFont.proximaNovaRegularFont(withSize: 24.0)
        
        
        let temperatureStackView = UIStackView(arrangedSubviews: [weatherImageView,
                                                                  locationLabel,
                                                                  weatherDetailLabel])
        temperatureStackView.axis = UILayoutConstraintAxis.vertical
        temperatureStackView.spacing = 12.0
        temperatureStackView.distribution = UIStackViewDistribution.fillProportionally
        temperatureStackView.alignment = UIStackViewAlignment.center
        
        
        humidityLabel = AccessorizedLabelView.newAutoLayout()
        humidityLabel.imagePosition = AccessoryImagePosition.top
        humidityLabel.image = UIImage(named: "Humidity")
        humidityLabel.textAlignment = NSTextAlignment.center
        humidityLabel.textColor = UIColor.primaryDarkTextColor()
        humidityLabel.font = UIFont.proximaNovaSemiboldFont(withSize: 15.0)
        
        
        precipitationLabel = AccessorizedLabelView.newAutoLayout()
        precipitationLabel.textAlignment = NSTextAlignment.center
        precipitationLabel.imagePosition = AccessoryImagePosition.top
        precipitationLabel.image = UIImage(named: "Precipitation")
        precipitationLabel.textColor = UIColor.primaryDarkTextColor()
        precipitationLabel.font = UIFont.proximaNovaSemiboldFont(withSize: 15.0)
        
        
        pressureLabel = AccessorizedLabelView.newAutoLayout()
        pressureLabel.imagePosition = AccessoryImagePosition.top
        pressureLabel.image = UIImage(named: "Pressure")
        pressureLabel.textAlignment = NSTextAlignment.center
        pressureLabel.textColor = UIColor.primaryDarkTextColor()
        pressureLabel.font = UIFont.proximaNovaSemiboldFont(withSize: 15.0)
        
        
        let indicatorContainerView = UIView.newAutoLayout()
        
        
        let topSeparatorImageView = UIImageView.newAutoLayout()
        topSeparatorImageView.image = UIImage(named: "Divider")
        
        indicatorContainerView.addSubview(topSeparatorImageView)
        
        topSeparatorImageView.autoAlignAxis(toSuperviewAxis: ALAxis.vertical)
        topSeparatorImageView.autoPinEdge(toSuperviewEdge: ALEdge.top)
        topSeparatorImageView.autoSetDimension(ALDimension.width,
                                               toSize: separatorViewWidth)
        
        
        let topIndicatorsStackView = UIStackView(arrangedSubviews: [humidityLabel,
                                                                    precipitationLabel,
                                                                    pressureLabel])
        topIndicatorsStackView.axis = UILayoutConstraintAxis.horizontal
        topIndicatorsStackView.spacing = 0.0
        topIndicatorsStackView.distribution = UIStackViewDistribution.fillEqually
        topIndicatorsStackView.alignment = UIStackViewAlignment.center
        
        indicatorContainerView.addSubview(topIndicatorsStackView)
        
        topIndicatorsStackView.autoPinEdge(toSuperviewEdge: ALEdge.left)
        topIndicatorsStackView.autoPinEdge(toSuperviewEdge: ALEdge.right)
        topIndicatorsStackView.autoPinEdge(ALEdge.top,
                                           to: ALEdge.bottom,
                                           of: topSeparatorImageView,
                                           withOffset: 24.0)
        
        
        windLabel = AccessorizedLabelView.newAutoLayout()
        windLabel.imagePosition = AccessoryImagePosition.top
        windLabel.image = UIImage(named: "Wind")
        windLabel.textAlignment = NSTextAlignment.center
        windLabel.textColor = UIColor.primaryDarkTextColor()
        windLabel.font = UIFont.proximaNovaSemiboldFont(withSize: 15.0)
        
        
        windDirectionLabel = AccessorizedLabelView.newAutoLayout()
        windDirectionLabel.imagePosition = AccessoryImagePosition.top
        windDirectionLabel.image = UIImage(named: "WindDirection")
        windDirectionLabel.textAlignment = NSTextAlignment.center
        windDirectionLabel.textColor = UIColor.primaryDarkTextColor()
        windDirectionLabel.font = UIFont.proximaNovaSemiboldFont(withSize: 15.0)
        
        
        let bottomIndicatorsStackView = UIStackView(arrangedSubviews: [windLabel, windDirectionLabel])
        bottomIndicatorsStackView.axis = UILayoutConstraintAxis.horizontal
        bottomIndicatorsStackView.spacing = 0.0
        bottomIndicatorsStackView.distribution = UIStackViewDistribution.fillEqually
        bottomIndicatorsStackView.alignment = UIStackViewAlignment.center
        
        indicatorContainerView.addSubview(bottomIndicatorsStackView)
        
        bottomIndicatorsStackView.autoMatch(ALDimension.width,
                                            to: ALDimension.width,
                                            of: topIndicatorsStackView,
                                            withMultiplier: 0.7)
        bottomIndicatorsStackView.autoPinEdge(ALEdge.top,
                                              to: ALEdge.bottom,
                                              of: topIndicatorsStackView,
                                              withOffset: 18.0)
        bottomIndicatorsStackView.autoAlignAxis(toSuperviewAxis: ALAxis.vertical)
        
        
        let bottomSeparatorImageView = UIImageView.newAutoLayout()
        bottomSeparatorImageView.image = UIImage(named: "Divider")
        
        indicatorContainerView.addSubview(bottomSeparatorImageView)
        
        bottomSeparatorImageView.autoAlignAxis(toSuperviewAxis: ALAxis.vertical)
        bottomSeparatorImageView.autoPinEdge(ALEdge.top,
                                             to: ALEdge.bottom,
                                             of: bottomIndicatorsStackView,
                                             withOffset: 24.0)
        bottomSeparatorImageView.autoSetDimension(ALDimension.width,
                                                  toSize: separatorViewWidth)
        indicatorContainerView.autoPinEdge(ALEdge.bottom,
                                           to: ALEdge.bottom,
                                           of: bottomSeparatorImageView)
        
        
        
        let shareButton = UIButton(type: UIButtonType.system)
        shareButton.setTitle("Share", for: UIControlState.normal)
        shareButton.titleLabel?.font = UIFont.proximaNovaSemiboldFont(withSize: 18.0)
        shareButton.setTitleColor(UIColor.primaryButtonTitleColor(), for: UIControlState.normal)
        shareButton.addTarget(self,
                              action: #selector(didTapShareButton(_:)),
                              for: UIControlEvents.touchUpInside)
        
        
        let containerStackView = UIStackView(arrangedSubviews: [UIView(),
                                                                temperatureStackView,
                                                                indicatorContainerView,
                                                                shareButton,
                                                                UIView()])
        containerStackView.axis = UILayoutConstraintAxis.vertical
        containerStackView.alignment = UIStackViewAlignment.center
        containerStackView.distribution = UIStackViewDistribution.equalSpacing
        
        view.addSubview(containerStackView)
        
        containerStackView.autoPinEdgesToSuperviewEdges()
        
        indicatorContainerView.autoPinEdge(toSuperviewEdge: ALEdge.left)
        indicatorContainerView.autoPinEdge(toSuperviewEdge: ALEdge.right)
    }
    
    // MARK: - Load Data
    
    override func loadData(withRefresh refresh: Bool) -> Bool {
        if !super.loadData(withRefresh: refresh) {
            return false
        }
        
        return true
    }
    
    // MARK: - Actions
    
    @objc func didTapShareButton(_ button: UIButton) {
        // TODO: - Show UIActivityViewController
    }
}

