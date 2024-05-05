//
//  Extensions.swift
//  rick-and-morty-app
//
//  Created by Дмитро Павлов on 05.05.2024.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach {
            addSubview($0)
        }
    }
}
