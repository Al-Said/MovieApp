//
//  MainPageViewController.swift
//  MovieApp
//
//  Created by Said Alır on 29.05.2021.
//

import UIKit
import NVActivityIndicatorView
import FirebaseAnalytics

class MainPageViewController: BaseViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var activityIndicator: NVActivityIndicatorView!
    @IBOutlet weak var moviesTable: UITableView!
    var data: [MovieTableCellViewModel] = [] { didSet {
        self.moviesTable.reloadData()
    }}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableViewAndSearchBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        activityIndicator.startAnimating()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setData()
    }
    
    func setupUI() {
        self.navigationItem.title = "Movie List"
        self.searchBar.text = "Matrix"
        activityIndicator.type = .orbit
        activityIndicator.color = .systemPink
    }
    
    func setupTableViewAndSearchBar() {
        self.moviesTable.delegate = self
        self.moviesTable.dataSource = self
        self.moviesTable.register(UINib(nibName: "MainTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "MainTableViewCell")
        self.searchBar.delegate = self
    }
    
    func setData() {
        SearchManager.shared.getSearchResults("matrix") { model in
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            if let data = model.result {
                for row in data {
                    self.data.append(MovieTableCellViewModel(model: row))
                }
            }
        } failure: { error in
            print(error)
        }
    }

}

extension MainPageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell") as? MainTableViewCell else {
            return UITableViewCell()
        }
        cell.configureCell(data[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController {
            vc.viewModel = MovieDetailViewModel(id: data[indexPath.row].id)
            Analytics.logEvent("pageChanged", parameters: ["pageName": "MainPage"])
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension MainPageViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count < 3 {
            return
        } else {
            self.data = []
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
            let search = String(searchText.filter { !" \n\t\r".contains($0) })
            SearchManager.shared.getSearchResults(search) { model in
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
                if let data = model.result, data.count > 0 {
                    for row in data {
                        self.data.append(MovieTableCellViewModel(model: row))
                    }
                } else {
                    self.showInfoPopup(title: NSLocalizedString("Error", comment: ""),
                                       message: NSLocalizedString("Movie Not Found!", comment: ""),
                                       buttonText: "Okay!")
                }
            } failure: { error in
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
                self.showInfoPopup(title: NSLocalizedString("Error", comment: ""),
                                   message: NSLocalizedString("Connection Error!", comment: ""),
                                   buttonText: "Okay!")
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
}


