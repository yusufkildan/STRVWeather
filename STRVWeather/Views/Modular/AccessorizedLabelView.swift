//
//  AccessorizedLabelView.swift
//  STRVWeather
//
//  Created by yusuf_kildan on 26.06.2018.
//  Copyright © 2018 yusuf_kildan. All rights reserved.
//

import UIKit
import PureLayout

enum AccessoryImagePosition {
    case left
    case top
}

class AccessorizedLabelView: UIView {
    
    fileprivate var imageView: UIImageView!
    fileprivate var titleLabel: UILabel!
    
    var image: UIImage! {
        didSet {
            imageView.image = image
        }
    }
    
    var title: String! {
        didSet {
            titleLabel.text = title
        }
    }
    
    var textColor: UIColor! = UIColor.primaryDarkTextColor() {
        didSet {
            titleLabel.textColor = textColor
        }
    }
    
    var font: UIFont! {
        didSet {
            titleLabel.font = font
        }
    }
    
    var textAlignment: NSTextAlignment! {
        didSet {
            titleLabel.textAlignment = textAlignment
        }
    }
    
    var imagePosition: AccessoryImagePosition! {
        didSet {
            if imagePosition == AccessoryImagePosition.left {
                imageView.autoPinEdge(toSuperviewEdge: ALEdge.left)
                imageView.autoAlignAxis(toSuperviewAxis: ALAxis.horizontal)
                titleLabel.autoPinEdge(ALEdge.left,
                                       to: ALEdge.right,
                                       of: imageView,
                                       withOffset: 6.0)
                titleLabel.autoPinEdge(toSuperviewEdge: ALEdge.right)
                titleLabel.autoPinEdge(toSuperviewEdge: ALEdge.top)
            }else {
                titleLabel.autoPinEdge(toSuperviewEdge: ALEdge.left)
                titleLabel.autoPinEdge(toSuperviewEdge: ALEdge.right)
                imageView.autoAlignAxis(toSuperviewAxis: ALAxis.vertical)
                imageView.autoPinEdge(toSuperviewEdge: ALEdge.top)
                imageView.autoPinEdge(ALEdge.bottom,
                                      to: ALEdge.top,
                                      of: titleLabel)
            }
        }
    }
    
    // MARK: - Constructors
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    fileprivate func commonInit() {
        imageView = UIImageView.newAutoLayout()
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        
        self.addSubview(imageView)
        
        
        titleLabel = UILabel.newAutoLayout()
        titleLabel.textColor = textColor
        
        self.addSubview(titleLabel)
        
        titleLabel.autoPinEdge(toSuperviewEdge: ALEdge.bottom)
    }
}
