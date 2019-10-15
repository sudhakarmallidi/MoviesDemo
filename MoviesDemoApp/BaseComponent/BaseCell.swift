//
//  BaseCell.swift
//  BaseComponent
//
//  Created by Sudhakar Reddy M on 15/10/19.
//  Copyright © 2019 Sudhakar Reddy M. All rights reserved.
//
import Foundation
import UIKit
open class BaseCell: UICollectionViewCell {
    public static var reuseIdentifier: String {
        return String(describing: self)
    }
    public static var nib: UINib {
        return UINib(nibName: self.reuseIdentifier, bundle: Bundle(for: self))
    }
}
