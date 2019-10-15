//
//  CarouselBgView.swift
//  SampleMovieList
//
//  Created by Sudhakar Reddy M on 15/10/19.
//  Copyright © 2019 Sudhakar Reddy M. All rights reserved.
//
import UIKit
import Foundation
import SnapKit
public class CarouselBgView: BaseView {
    static public func viewFromNib() -> CarouselBgView {
        return (nib.instantiate(withOwner: nil, options: nil).first as? CarouselBgView)!
    }
    public var backgroundCDColor: UIColor? = ColorUtils.white
    public var shadowCDColor: UIColor?
    @IBOutlet weak var imgPoster: UIImageView!
    override open func didMoveToSuperview() {
        super.didMoveToSuperview()
        if self.superview != nil {
            self.snp.makeConstraints { (make) -> Void in
                make.edges.equalToSuperview()
            }
        }
    }
    override public func layoutSubviews() {
        super.layoutSubviews()
        self.clipsToBounds = true
    }
}
