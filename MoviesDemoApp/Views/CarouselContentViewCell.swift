//
//  CarouselContentViewCell.swift
//  SampleMovieList
//
//  Created by Sudhakar Reddy M on 15/10/19.
//  Copyright © 2019 Sudhakar Reddy M. All rights reserved.
//

import UIKit
class CarouselContentViewCell: BaseCell {
    static let cellHeight: CGFloat = 250
    lazy var innerContainerView: CarouselBgView = {
        let view = CarouselBgView.viewFromNib()
        view.backgroundColor = .clear
        return view
    }()
    func loadCellWithData(imageURL: String?) {
        innerContainerView.imgPoster.loadImageUsingCache(withUrl: imageURL ?? "")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addSubview(innerContainerView)
        
    }
}
