//
//  LikeControlPanel.swift
//  gb_second
//
//  Created by Artem Fedorchenko on 1/17/21.
//

import UIKit

class LikeControlPanel: UIControl {
    private var stackView: UIStackView!
    private let button = UIButton(type: .system)
    var counterLabel = UILabel()
    
    var isLiked: Bool = false {
        didSet {
            self.sendActions(for: .valueChanged)
            if !oldValue {
                counter += 1
            } else {
                counter -= 1
            }
            self.updateControl()
        }
    }
    var counter: Int = 0
    
    override init(frame: CGRect) {
         super.init(frame: frame)
        
         self.setupView()
     }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.setupView()
    }
    
    private func setupView() {
        button.setImage(UIImage(systemName: isLiked ? "heart.fill" : "heart"), for: .normal)
        button.tintColor = isLiked ? .systemPink : .black
        button.addTarget(self, action: #selector(toogleIsLiked(_ :)), for: .touchUpInside)
        counterLabel.text = String(counter)
        counterLabel.textColor = isLiked ? .systemPink : .black
        
        stackView = UIStackView(arrangedSubviews: [counterLabel, button])

        stackView.spacing = 4
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        
        self.addSubview(stackView)
    }

    @objc func toogleIsLiked(_ sender: UIButton) {
        isLiked.toggle()
    }
    
    private func updateControl() {
        button.setImage(UIImage(systemName: isLiked ? "heart.fill" : "heart"), for: .normal)
        button.tintColor = isLiked ? .systemPink : .black
        counterLabel.textColor = isLiked ? .systemPink : .black
        counterLabel.text = String(counter)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        stackView.frame = bounds
    }
}

