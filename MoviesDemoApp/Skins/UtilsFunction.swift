//
//  UtilsFunction.swift
//  SampleMovieList
//
//  Created by Sudhakar Reddy M on 15/10/19.
//  Copyright © 2019 Sudhakar Reddy M. All rights reserved.
//

import Foundation
import UIKit

struct UtilsFunction {

    static func heightOfLableAccordingContent(_ width: CGFloat,
                                              _ font: UIFont,
                                              _ text: String, numberOfLines: Int ) -> CGFloat {
        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = numberOfLines
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.height
    }
    static func showOnLoader() {
        SKActivityIndicator.spinnerStyle(.spinningHalfCircles)
        SKActivityIndicator.show("Loading...")
    }
    static func hideOffLoader() {
        SKActivityIndicator.dismiss()
    }
}
