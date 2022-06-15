//
//  UIView+Extension.swift
//  IssueTracker
//
//  Created by 김동준 on 2022/06/15.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView ...) {
        for view in views {
            addSubview(view)
        }
    }
}

