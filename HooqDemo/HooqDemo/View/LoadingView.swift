//
//  LoadingView.swift
//  HooqDemo
//
//  Created by Gagan on 2/3/2019.
//  Copyright © 2018 Gagan. All rights reserved.
//

import Foundation
import UIKit

class LoadingView : UIView {
    
    @IBOutlet weak var activityView: UIView!
    class func newInstance() -> LoadingView {
        let nibs = Bundle.main.loadNibNamed("LoadingView", owner: nil, options: nil)! as [AnyObject]
        let loadingScreen = nibs.first as! LoadingView
        return loadingScreen
    }
    
    // MARK:- Handlers
    func show() {
        let window = UIApplication.shared.keyWindow!
        self.frame = window.frame
        
        self.alpha = 0.0
        window.addSubview(self)
        UIView.animate(withDuration: GlobalConstants.LoadingViewAnimation) {
            self.alpha = 1.0
        }
    }
    
    func hide() {
        UIView.animate(withDuration: GlobalConstants.LoadingViewAnimation, delay: GlobalConstants.LoadingViewDelay, options: .curveEaseIn, animations: {
                self.alpha = 0.0
        }, completion: { _ -> () in
            self.removeFromSuperview()
        })
    }
}
