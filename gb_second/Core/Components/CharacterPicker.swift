//
//  CharacterPicker.swift
//  gb_second
//
//  Created by Artem Fedorchenko on 1/16/21.
//

import UIKit

class CharacterPicker: UIControl {    
    var Chars: [String]? = []
    private var buttons: [UIButton] = []
    private var stackView: UIStackView!
    
    var selectedChar: String? = nil {
        didSet {
            sendActions(for: .valueChanged)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupUI()
    }
    
    func setupUI() {
        for char in Chars! {
            let button = UIButton(type: .system)
            button.setTitle(char, for: .normal)
            button.setTitleColor(.systemBlue, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 10, weight: .bold)
            button.setTitleColor(.white, for: .selected)
            button.addTarget(self, action: #selector(selectChar), for: .touchUpInside)
            buttons.append(button)
        }
        
        stackView = UIStackView(arrangedSubviews: buttons)
        
        stackView.axis = .vertical
        stackView.spacing = 6
        stackView.alignment = .trailing
        stackView.distribution = .fillEqually
        stackView.contentMode = .scaleAspectFill
        
        addSubview(stackView)
    }
    
    @objc func selectChar(_ sender: UIButton) {
        guard let index = buttons.firstIndex(of: sender),
              let char: String = Chars?[index] else { return }
        selectedChar = char
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        stackView.frame = bounds
    }

}

