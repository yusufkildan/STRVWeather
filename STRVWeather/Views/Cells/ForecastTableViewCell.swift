//
//  ForecastTableViewCell.swift
//  STRVWeather
//
//  Created by yusuf_kildan on 26.06.2018.
//  Copyright © 2018 yusuf_kildan. All rights reserved.
//

import UIKit
import PureLayout

let ForecastTableViewCellReuseIdentifier = NSStringFromClass(ForecastTableViewCell.classForCoder())

class ForecastTableViewCell: UITableViewCell {
    
    let ImageViewDimension: CGFloat = 60.0
    let DefaultInset: CGFloat = 18.0
    
    fileprivate var weatherImageView: UIImageView!
    fileprivate var timeLabel: UILabel!
    fileprivate var weatherDescriptionLabel: UILabel!
    fileprivate var temperatureLabel: UILabel!
    
    var weatherImage: UIImage! {
        didSet {
            weatherImageView.image = weatherImage
        }
    }
    
    var time: String! {
        didSet {
            timeLabel.text = time
        }
    }
    
    var weatherDescription: String! {
        didSet {
            weatherDescriptionLabel.text = weatherDescription
        }
    }
    
    var temperature: String! {
        didSet {
            temperatureLabel.text = temperature
        }
    }
    
    // MARK: - Constructors
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    fileprivate func commonInit() {
        weatherImageView = UIImageView.newAutoLayout()
        
        contentView.addSubview(weatherImageView)
        
        weatherImageView.autoPinEdge(toSuperviewEdge: ALEdge.left,
                                     withInset: DefaultInset)
        weatherImageView.autoSetDimensions(to: CGSize(width: ImageViewDimension,
                                                      height: ImageViewDimension))
        weatherImageView.autoAlignAxis(toSuperviewAxis: ALAxis.horizontal)
        
        
        temperatureLabel = UILabel.newAutoLayout()
        temperatureLabel.textColor = UIColor.secondaryDarkTextColor()
        temperatureLabel.font = UIFont.proximaNovaLightFont(withSize: 50.0)
        temperatureLabel.textAlignment = NSTextAlignment.right
        
        contentView.addSubview(temperatureLabel)
        
        temperatureLabel.autoPinEdge(toSuperviewEdge: ALEdge.right, withInset: DefaultInset)
        temperatureLabel.autoSetDimension(ALDimension.width, toSize: 81.0)
        temperatureLabel.autoSetDimension(ALDimension.height, toSize: 40.0)
        temperatureLabel.autoAlignAxis(toSuperviewAxis: ALAxis.horizontal)
        
        
        timeLabel = UILabel.newAutoLayout()
        timeLabel.textColor = UIColor.primaryDarkTextColor()
        timeLabel.font = UIFont.proximaNovaSemiboldFont(withSize: 18.0)
        
        
        weatherDescriptionLabel = UILabel.newAutoLayout()
        weatherDescriptionLabel.textColor = UIColor.primaryDarkTextColor()
        weatherDescriptionLabel.font = UIFont.proximaNovaRegularFont(withSize: 15.0)
        
        
        let informationLabelsStackView = UIStackView(arrangedSubviews: [timeLabel,
                                                                        weatherDescriptionLabel])
        informationLabelsStackView.axis = UILayoutConstraintAxis.vertical
        informationLabelsStackView.spacing = 5.0
        informationLabelsStackView.distribution = UIStackViewDistribution.fill
        informationLabelsStackView.alignment = UIStackViewAlignment.leading
        
        contentView.addSubview(informationLabelsStackView)
        
        informationLabelsStackView.autoPinEdge(ALEdge.left,
                                               to: ALEdge.right,
                                               of: weatherImageView,
                                               withOffset: 26.0)
        informationLabelsStackView.autoAlignAxis(toSuperviewAxis: ALAxis.horizontal)
        informationLabelsStackView.autoPinEdge(ALEdge.right,
                                               to: ALEdge.left,
                                               of: temperatureLabel,
                                               withOffset: -4.0)
    }
    
    // MARK: - Cell Height
    
    class func cellHeight() -> CGFloat {
        return 90.0
    }
}
