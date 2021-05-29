//
//  BaseViewController.swift
//  MovieApp
//
//  Created by Said Alır on 29.05.2021.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func showInfoPopup(title: String, message: String, buttonText: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonText, style: .default, handler: { (_) in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }

}
