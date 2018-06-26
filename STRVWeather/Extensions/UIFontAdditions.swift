//
//  UIFontAdditions.swift
//  STRVWeather
//
//  Created by yusuf_kildan on 26.06.2018.
//  Copyright © 2018 yusuf_kildan. All rights reserved.
//

import UIKit

extension UIFont {
    
    // MARK: - Proxima Nova
    
    public class func proximaNovaBoldFont(withSize size: CGFloat) -> UIFont {
        return UIFont(name: "ProximaNova-Bold", size: size)!
    }
    
    public class func proximaNovaLightFont(withSize size: CGFloat) -> UIFont {
        return UIFont(name: "ProximaNova-Light", size: size)!
    }
    
    public class func proximaNovaRegularFont(withSize size: CGFloat) -> UIFont {
        return UIFont(name: "ProximaNova-Regular", size: size)!
    }
    
    public class func proximaNovaSemiboldFont(withSize size: CGFloat) -> UIFont {
        return UIFont(name: "ProximaNova-Semibold", size: size)!
    }
}
