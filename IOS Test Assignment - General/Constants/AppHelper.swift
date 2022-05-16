//
//  AppHelper.swift
//  IOS Test Assignment - General
//
//  Created by Ammar Ul Haq on 16/05/2022.
//

import UIKit
import Reachability
import MBProgressHUD

class AppHelper: NSObject {
    
    static let sharedInstance = AppHelper()
    
    func checkInternetConn(completionHandler: @escaping (String, Bool) -> Void){
        let status = Reach().connectionStatus()
        
        switch status {
        case .unknown, .offline:
            completionHandler("", false)
        case .online(.wwan):
            completionHandler("wwan", true)
        case .online(.wiFi):
            completionHandler("wifi", true)
        }
    }

}


extension UIView {
    func addGradientBackground() {
        let random = UIColor.random().cgColor
        let random2 = UIColor.random().cgColor

        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [UIColor.red, UIColor.purple]

        layer.insertSublayer(gradient, at: 0)
    }
}

extension UIColor {
    static func random() -> UIColor {
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
}


extension UIViewController {

    func showHUD(progressLabel:String){
        DispatchQueue.main.async{
            let progressHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
            progressHUD.label.text = progressLabel
        }
    }

    func dismissHUD(isAnimated:Bool) {
        DispatchQueue.main.async{
            MBProgressHUD.hide(for: self.view, animated: isAnimated)
        }
    }
}
