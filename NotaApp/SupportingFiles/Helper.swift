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
            
    class func showAlert(title: String, message: String, actionTitle: String ,viewController: UIViewController) -> Void
    {
        let alertController = UIAlertController(title: title, message:
            message, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: actionTitle, style: UIAlertAction.Style.default,handler: nil))
        
        viewController.present(alertController, animated: true, completion: nil)
    }
            
    class func showViewByIdentifer( storyboardID: String, viewControllerID: String)
    {
        guard let window = UIApplication.shared.keyWindow else { return }
        
        let sb = UIStoryboard(name: storyboardID, bundle: nil)
        var vc: UIViewController
        
        vc = sb.instantiateViewController(withIdentifier: viewControllerID)
        
        window.rootViewController = vc
        
    }
            
}
