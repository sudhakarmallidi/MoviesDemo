//
//  MovieCell.swift
//  SampleMovieList
//
//  Created by Sudhakar Reddy M on 15/10/19.
//  Copyright © 2019 Sudhakar Reddy M. All rights reserved.
//

import UIKit
class MovieCell: BaseCell {
    static let cellHeight: CGFloat = 220
    @IBOutlet weak var viewBG: UIView! {
        didSet {
            viewBG.layer.cornerRadius = 5
            viewBG.layer.masksToBounds = true
            viewBG.clipsToBounds = true
        }
    }
    @IBOutlet weak var imgPoster: UIImageView! {
        didSet {
            imgPoster.backgroundColor = .clear
            imgPoster.layer.cornerRadius = 5
            imgPoster.layer.masksToBounds = true
            imgPoster.clipsToBounds = true
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        viewBG.shadowStyle(CGSize.zero, .allCorners, ColorUtils.blueGray, 0.70)
    }
    func configureCellWithData(moviePostUrl: String?, title: String?) {
        imgPoster.loadImageUsingCache(withUrl: moviePostUrl ?? "")
        titleLabel.text = title ?? ""
    }
}
