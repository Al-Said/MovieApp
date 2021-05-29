//
//  MovieDetailViewController.swift
//  MovieApp
//
//  Created by Said Alır on 29.05.2021.
//

import UIKit
import Kingfisher
import NVActivityIndicatorView
import Firebase

class MovieDetailViewController: BaseViewController {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var detailTableView: UITableView!
    @IBOutlet weak var activityIndicator: NVActivityIndicatorView!
    
    var viewModel: MovieDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        activityIndicator.startAnimating()
        setData()
    }
    
    func setupTable() {
        self.detailTableView.delegate = self
        self.detailTableView.dataSource = self
    }
    
    func setupUI() {
        self.navigationItem.title = "Movie Detail"
        activityIndicator.type = .ballScale
        activityIndicator.color = .magenta
    }
    
    func setData() {
        viewModel.fetchData {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            if let url = self.viewModel.poster {
                self.posterImageView.kf.setImage(with: url,
                                                 placeholder: UIImage(named: "placeholderImage"),
                                                 options: nil,
                                                 completionHandler: nil)
            }
            self.detailTableView.reloadData()
        }
    }
}

extension MovieDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let text = viewModel.data[indexPath.row]
        cell.textLabel?.text = text
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        if text.lowercased() == "read plot" || text.lowercased() == "see actors" {
            cell.textLabel?.textColor = .systemBlue
            cell.textLabel?.textAlignment = .center
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let text = viewModel.data[indexPath.row]
        if text.lowercased() == "read plot" {
            let title = NSLocalizedString("Plot", comment: "plot")
            let ok = NSLocalizedString("OK", comment: "ok")
            self.showInfoPopup(title: title, message: viewModel.plot ?? "", buttonText: ok)
            Analytics.logEvent("plotRead", parameters: ["Movie": viewModel.title ?? "UNKNOWN"])
        } else if text.lowercased() == "see actors" {
            let title = NSLocalizedString("Actors", comment: "actors")
            let ok = NSLocalizedString("OK", comment: "ok")
            self.showInfoPopup(title: title,
                               message: viewModel.actors?.joined(separator: "\n") ?? "",
                               buttonText: ok)
            Analytics.logEvent("actorsShown", parameters: ["Movie": viewModel.title ?? "UNKNOWN"])
        }
    }
}
