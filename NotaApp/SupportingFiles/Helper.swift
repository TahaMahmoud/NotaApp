//
//  Helper.swift
//  NotaApp
//
//  Created by Taha on 12/2/19.
//  Copyright © 2019 Taha. All rights reserved.
//

import Foundation
import SystemConfiguration
import UIKit

class Helper {
        
    class func checkConnection () -> Bool
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
        
    }
    
    class func showAlert(title: String, message: String, actionTitle: String ,viewController: UIViewController) -> Void
    {
        let alertController = UIAlertController(title: title, message:
            message, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: actionTitle, style: UIAlertAction.Style.default,handler: nil))
        
        viewController.present(alertController, animated: true, completion: nil)
    }
        
    class func restartApp()
    {
        // view the main screen
        guard let window = UIApplication.shared.keyWindow else { return }
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        var vc: UIViewController
        
        vc = sb.instantiateViewController(withIdentifier: "MainVC")
        
        window.rootViewController = vc
        
        UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromBottom, animations: nil, completion: nil)
        
    }
    
    class func showViewByIdentifer( storyboardID: String, viewControllerID: String)
    {
        guard let window = UIApplication.shared.keyWindow else { return }
        
        let sb = UIStoryboard(name: storyboardID, bundle: nil)
        var vc: UIViewController
        
        vc = sb.instantiateViewController(withIdentifier: viewControllerID)
        
        window.rootViewController = vc
        
    }
    
    class func displaySpinner(onView : UIView) -> UIView {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        return spinnerView
    }
    
    class func removeSpinner(spinner :UIView) {
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
        
}
