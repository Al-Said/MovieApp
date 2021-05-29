//
//  ViewController.swift
//  MovieApp
//
//  Created by Said Alır on 29.05.2021.
//

import UIKit
import Reachability
import FirebaseAnalytics
import FirebaseRemoteConfig


class SplashViewController: BaseViewController {
    
    @IBOutlet weak var remoteConfigLabel: UILabel!
    private let remoteConfig = RemoteConfig.remoteConfig()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRemoteConfig()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkReachability()
    }
    
    func setupRemoteConfig() {
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
    }
    
    func checkReachability() {
        do {
            let reachability = try Reachability()
            NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
            try reachability.startNotifier()
            switch reachability.connection {
            case .unavailable:
                self.showInfoPopup(title: NSLocalizedString("Error", comment: ""),
                                   message: NSLocalizedString("To continue please connect to internet!", comment: ""),
                                   buttonText: NSLocalizedString("Okay", comment: ""))
            default:
                setRemoteConfigLabel()
                break
            }
            
        } catch {
            self.remoteConfigLabel.text = "couldn't start"
            print("could not start reachability notifier")
        }
    }
    
    func setRemoteConfigLabel() {
        //set remote config label
        self.remoteConfig.fetch(withExpirationDuration: 60) { status, error in
            if status == .success, error == nil {
                self.remoteConfig.activate { _, err in
                    guard err == nil else { return }
                    let text = self.remoteConfig.configValue(forKey: "splashText").stringValue ?? ""
                    DispatchQueue.main.async {
                        self.remoteConfigLabel.text = text
                    }
                }
                self.openNextPage()
            } else {
                print(error ?? "")
            }
        }
    }
    
    func openNextPage() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            guard let window = self.view.window else { return }
            if let main = self.storyboard?.instantiateViewController(withIdentifier: "MainNavigation") {
                Analytics.logEvent("pageChanged", parameters: ["pageName": "MainPage"])
                window.switchRootViewController(main)
            }
        }
    }
    
    @objc func reachabilityChanged(note: Notification) {
        let reachability = note.object as! Reachability
        switch reachability.connection {
        case .wifi, .cellular:
            setRemoteConfigLabel()
            break
        case .unavailable:
            print("Network not reachable")
        default:
            break
        }
    }
}

