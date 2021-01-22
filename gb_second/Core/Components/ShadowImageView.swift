//
//  ShadowImageView.swift
//  gb_second
//
//  Created by Artem Fedorchenko on 1/17/21.
//

import UIKit

class ShadowImageView: UIImageView {
    @IBInspectable
    var color: UIColor = .black {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable
    var opacity: Float = 0.5 {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable
    var radius: CGFloat = 5 {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable
    var cornerRadius: CGFloat = 1 {
        didSet {
            setNeedsLayout()
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        layer.shadowOffset = .zero
        
        layer.cornerRadius = frame.width / cornerRadius
        layer.masksToBounds = false
    }
}
