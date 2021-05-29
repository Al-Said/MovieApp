//
//  UIWindow+Extension.swift
//  MovieApp
//
//  Created by Said Alır on 29.05.2021.
//

import UIKit

extension UIWindow {
    
    func switchRootViewController(_ viewController: UIViewController,
                                  animated: Bool = true,
                                  duration: TimeInterval = 0.5,
                                  options: AnimationOptions = .transitionFlipFromRight,
                                  completion: (() -> Void)? = nil) {
        guard animated else {
            rootViewController = viewController
            return
        }
        
        UIView.transition(with: self, duration: duration, options: options, animations: {
            let oldState = UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            self.rootViewController = viewController
            UIView.setAnimationsEnabled(oldState)
        }, completion: { _ in
            completion?()
        })
    }
    
}
