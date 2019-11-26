//
//  UIAlertExtension.swift
//  HooqDemo
//
//  Created by Gagan on 1/3/2019.
//  Copyright © 2018 Gagan. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    //MARK:- Alerts
    func showAlertPopUp(message: String) {
        let alertController = UIAlertController(title: GlobalConstants.AppName, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}


