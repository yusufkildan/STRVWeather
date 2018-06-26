//
//  BaseViewController.swift
//  STRVWeather
//
//  Created by yusuf_kildan on 26.06.2018.
//  Copyright © 2018 yusuf_kildan. All rights reserved.
//

import UIKit
import PureLayout

enum ControllerState {
    case none
    case loading
    case error
}

class BaseViewController: UIViewController {
    
    fileprivate var subComponentsHolderView: UIView!
    
    fileprivate var loadingIndicator: UIActivityIndicatorView!
    
    fileprivate var statusLabel: UILabel!
    
    fileprivate var state: ControllerState! = ControllerState.none
    
    var strictBackgroundColor: UIColor? {
        didSet {
            view.backgroundColor = strictBackgroundColor
            
            if let holderView = subComponentsHolderView {
                holderView.backgroundColor = strictBackgroundColor
            }
        }
    }
    
    // MARK: - Constructors
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        commonInit()
    }
    
    fileprivate func commonInit() {
        
    }
    
    // MARK: - View's Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        subComponentsHolderView = UIView.newAutoLayout()
        subComponentsHolderView.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                            action: #selector(didTapSubComponentsHolderBackground(_:))))
        
        view.addSubview(subComponentsHolderView)
        
        subComponentsHolderView.autoPinEdge(toSuperviewEdge: ALEdge.left)
        subComponentsHolderView.autoPinEdge(toSuperviewEdge: ALEdge.right)
        subComponentsHolderView.autoPinEdge(toSuperviewEdge: ALEdge.top,
                                            withInset: 0.0)
        subComponentsHolderView.autoPinEdge(toSuperviewEdge: ALEdge.bottom,
                                            withInset: 0.0)
        
        setSubComponents(Visible: false, animated: false, completion: nil)
        
        
        strictBackgroundColor = UIColor.primaryBackgroundColor()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let controller = navigationController {
            controller.setNavigationBarHidden(!shouldShowNavigationBar(), animated: true)
            
            controller.navigationBar.barTintColor = navigationBarTintColor()
            
            controller.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: NavigationBarTitleFont,
                                                            NSAttributedStringKey.foregroundColor: navigationBarTitleColor()]
            
            if shouldShowColorfulLineUnderNavigationBar() {
                let image = UIImage(named: "ColorfulLine")
                let size = CGSize(width: UIScreen.main.bounds.width, height: (image?.size.height)!)
                
                UIGraphicsBeginImageContextWithOptions(size, true, 0.0)
                image?.draw(in: CGRect(origin: .zero, size: size))
                let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                
                controller.navigationBar.shadowImage = scaledImage
            } else {
                controller.navigationBar.shadowImage = UIImage()
            }
        }
    }
    
    // MARK: - Interface
    
    fileprivate func setSubComponents(Visible visible: Bool, animated: Bool, completion: (() -> Void)?) {
        
        view.bringSubview(toFront: subComponentsHolderView)
        
        func set(Visible visible: Bool) {
            subComponentsHolderView.alpha = visible ? 1.0 : 0.0
        }
        
        if visible {
            
            subComponentsHolderView.isHidden = false
        }
        
        if animated {
            UIView.animate(withDuration: 0.33, animations: {
                set(Visible: visible)
            }, completion: { (completed) in
                self.subComponentsHolderView.isHidden = !visible
                
                if let completion = completion {
                    completion()
                }
            })
        } else {
            set(Visible: visible)
            
            if let completion = completion {
                completion()
            }
        }
    }
    
    // MARK: - Load Data
    
    @discardableResult
    func loadData(withRefresh refresh: Bool) -> Bool {
        if (state == ControllerState.loading) {
            return false
        }
        
        state = ControllerState.loading
        
        startLoading()
        
        return true
    }
    
    func finishLoading(withState state: ControllerState, andMessage message: String?) {
        switch state {
        case .none:
            if let label = statusLabel {
                label.isHidden = true
                
                label.text = ""
            }
            
            setSubComponents(Visible: false, animated: true, completion: {
                self.stopLoading()
            })
        case .error:
            if statusLabel == nil {
                statusLabel = UILabel.newAutoLayout()
                statusLabel.textAlignment = NSTextAlignment.center
                statusLabel.textColor = UIColor.primaryDarkTextColor()
                statusLabel.font = UIFont.proximaNovaSemiboldFont(withSize: 16.0)
                statusLabel.numberOfLines = 0
                
                subComponentsHolderView.addSubview(statusLabel)
                
                let insets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
                statusLabel.autoPinEdgesToSuperviewEdges(with: insets)
            }
            
            setSubComponents(Visible: true, animated: true, completion: {
                self.statusLabel.isHidden = false
                
                self.statusLabel.text = message
                
                self.stopLoading()
            })
        default:
            break
        }
        
        self.state = state
    }
    
    fileprivate func startLoading() {
        if loadingIndicator == nil {
            loadingIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
            loadingIndicator.hidesWhenStopped = true
            
            subComponentsHolderView.addSubview(loadingIndicator)
            
            loadingIndicator.autoCenterInSuperview()
        }
        
        if let label = statusLabel {
            label.isHidden = true
            
            label.text = ""
        }
        
        loadingIndicator.isHidden = false
        
        loadingIndicator.startAnimating()
        
        setSubComponents(Visible: true, animated: true, completion: nil)
    }
    
    fileprivate func stopLoading() {
        guard let _ = loadingIndicator else {
            return
        }
        
        loadingIndicator.stopAnimating()
        
        loadingIndicator.isHidden = true
    }
    
    // MARK: - Gestures
    
    @objc fileprivate func didTapSubComponentsHolderBackground(_ recognizer: UITapGestureRecognizer) {
        if state == ControllerState.error {
            backgroundTapHandlerOnError()
        }
    }
    
    func backgroundTapHandlerOnError() {
        loadData(withRefresh: true)
    }
    
    // MARK: - Navigation
    
    func shouldShowNavigationBar() -> Bool {
        return true
    }
    
    func shouldShowColorfulLineUnderNavigationBar() -> Bool {
        return true
    }
    
    func navigationBarTintColor() -> UIColor {
        return UIColor.primaryBackgroundColor()
    }
    
    func navigationBarTitleColor() -> UIColor {
        return UIColor.primaryNavigationComponentColor()
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.default
    }
    
    // MARK: - Insets
    
    func defaultTopInset() -> CGFloat {
        var topInset: CGFloat = 0.0
        
        let application = UIApplication.shared
        
        if application.isStatusBarHidden == false {
            topInset += application.statusBarFrame.size.height
        }
        
        if shouldShowNavigationBar() {
            if let controller = navigationController {
                topInset += controller.navigationBar.frame.size.height
            }
        }
        
        return topInset
    }
    
    func defaultBottomInset() -> CGFloat {
        guard let controller = self.tabBarController else {
            return 0.0
        }
        
        return controller.tabBar.frame.size.height
    }
    
    // MARK: - UIAlertController
    
    func displayAlertWith(title: String, andMessage message: String) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: UIAlertControllerStyle.alert)
        
        let closeAction = UIAlertAction(title: "Ok",
                                        style: .default,
                                        handler: { (action) -> Void in
                                            alertController.dismiss(animated: true,
                                                                    completion: nil)
        })
        
        alertController.addAction(closeAction)
        
        self.present(alertController,
                     animated: true,
                     completion: nil)
    }
}
