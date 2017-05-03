//
//  Alerts.swift
//  jay-working-v2
//
//  Copyright © 2017 Jay. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String) {
        
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "OK"), style: .default, handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
}
