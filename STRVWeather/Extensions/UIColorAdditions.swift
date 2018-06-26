//
//  UIColorAdditions.swift
//  STRVWeather
//
//  Created by yusuf_kildan on 26.06.2018.
//  Copyright © 2018 yusuf_kildan. All rights reserved.
//

import UIKit

extension UIColor {
    
    // MARK: - Helper Functions
    
    class func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    // MARK: - Navigation Color
    
    public class func primaryNavigationComponentColor() -> UIColor {
        return hexStringToUIColor(hex: "#333333")
    }
    
    // MARK: - Background Color
    
    public class func primaryBackgroundColor() -> UIColor {
        return UIColor.white
    }
    
    // MARK: - Text Color
    
    public class func primaryDarkTextColor() -> UIColor {
        return hexStringToUIColor(hex: "#333333")
    }
    
    public class func secondaryDarkTextColor() -> UIColor {
        return hexStringToUIColor(hex: "#2F91FF")
    }
    
    // MARK: - Separator Color
    
    public class func listSeparatorColor() -> UIColor {
        return hexStringToUIColor(hex: "#DEDEDE")
    }
    
    // MARK: - Button Color
    
    public class func primaryButtonTitleColor() -> UIColor {
        return hexStringToUIColor(hex: "#FF8847")
    }
}
