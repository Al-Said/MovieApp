//
//  MainTableViewCell.swift
//  MovieApp
//
//  Created by Said Alır on 29.05.2021.
//

import UIKit
import Kingfisher

class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        posterImage.layer.shadowColor = UIColor.black.cgColor
        posterImage.layer.shadowRadius = 5.0
        posterImage.layer.shadowOpacity = 0.8
        self.titleLabel.adjustsFontSizeToFitWidth = true
        self.yearLabel.adjustsFontSizeToFitWidth = true
        self.typeLabel.adjustsFontSizeToFitWidth = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(_ model: MovieTableCellViewModel) {
        self.titleLabel.text = model.title
        self.yearLabel.text = model.year
        self.typeLabel.text = model.type.rawValue.uppercased()
        
        if let url = model.poster {
            self.posterImage.kf.indicatorType = .activity
            self.posterImage.kf.setImage(with: url,
                                         placeholder: UIImage(named: "placeholderImage"),
                                         options: nil,
                                         completionHandler: nil)
        }
    }
    
}
