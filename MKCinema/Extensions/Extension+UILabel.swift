//
//  Extension+UILabel.swift
//  MKCinema
//
//  Created by Admin on 1/12/21.
//

import UIKit

extension UILabel {
    convenience init(title: String = "label",
                     font: UIFont = .systemFont(ofSize: 14),
                     numberOfLines: Int = 1,
                     lineBreakMode: NSLineBreakMode = .byWordWrapping,
                     textAlignment: NSTextAlignment = .left) {
        
        self.init()
        self.text = title
        self.font = font
        self.numberOfLines = numberOfLines
        self.lineBreakMode = lineBreakMode
        self.textAlignment = textAlignment
        translatesAutoresizingMaskIntoConstraints = false
    }
}
