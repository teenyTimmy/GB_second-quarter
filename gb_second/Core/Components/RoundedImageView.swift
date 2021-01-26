//
//  RoundedImageView.swift
//  gb_second
//
//  Created by Artem Fedorchenko on 1/19/21.
//

import UIKit

class RoundedImage: UIImageView {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = frame.width / 2
        layer.masksToBounds = true
        self.contentMode = .scaleAspectFill
    }
}
