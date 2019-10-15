//
//  BaseReusableTableView.swift
//  SampleMovieList
//
//  Created by Sudhakar Reddy M on 16/10/19.
//  Copyright © 2019 Sudhakar Reddy M. All rights reserved.
//

import UIKit
class BaseReusableTableView: UITableViewCell {
    public static var reuseIdentifier: String {
        return String(describing: self)
    }
    public static var nib: UINib {
        return UINib(nibName: self.reuseIdentifier, bundle: Bundle(for: self))
    }
}
