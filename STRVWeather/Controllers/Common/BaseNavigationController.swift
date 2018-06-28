//
//  BaseNavigationController.swift
//  STRVWeather
//
//  Created by yusuf_kildan on 26.06.2018.
//  Copyright © 2018 yusuf_kildan. All rights reserved.
//

import UIKit

let NavigationBarTitleFont = UIFont.proximaNovaSemiboldFont(withSize: 18.0)

class BaseNavigationController: UINavigationController, UINavigationControllerDelegate {
    
    // MARK: - Constructors
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    // MARK: - View's Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.barTintColor = UIColor.primaryBackgroundColor()
        navigationBar.isTranslucent = false
        navigationBar.titleTextAttributes = [NSAttributedStringKey.font: NavigationBarTitleFont,
                                             NSAttributedStringKey.foregroundColor: UIColor.primaryNavigationComponentColor()]
        
        navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationBar.shadowImage = UIImage()
        
        delegate = self
        
        interactivePopGestureRecognizer?.delegate = nil
    }
}
