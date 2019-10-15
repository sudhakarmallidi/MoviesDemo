//
//  MovieDetailListCell.swift
//  SampleMovieList
//
//  Created by Sudhakar Reddy M on 16/10/19.
//  Copyright © 2019 Sudhakar Reddy M. All rights reserved.
//

import UIKit
class MovieDetailListCell: BaseReusableTableView {
    static let cellHeight: CGFloat = 70
    @IBOutlet weak var lblTittle: UILabel! {
        didSet {
            lblTittle.font = FontUtils.title3
            lblTittle.textColor = ColorUtils.lightGreyBlue
        }
    }
    @IBOutlet weak var lblSubTittle: UILabel! {
        didSet {
            lblSubTittle.font = FontUtils.body
            lblSubTittle.textColor = ColorUtils.white
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configureCellWithData(tittle: String?, subTittle: String?) {
        lblTittle.text = tittle
        lblSubTittle.text = subTittle
    }
}
