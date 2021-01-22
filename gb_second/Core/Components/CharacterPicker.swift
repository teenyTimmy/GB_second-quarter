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

    var selectedChar: String? {
        didSet {
            sendActions(for: .valueChanged)
        }
    }

    private var stackViewHeightAnchor: CGFloat = 0

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setupUI()
    }

//    func setupUI() {
//        stackViewHeightAnchor = CGFloat(Chars!.count * 18)
//
//        for char in Chars! {
//            let button = UIButton(type: .system)
//            button.setTitle(char, for: .normal)
//            button.setTitleColor(.systemBlue, for: .normal)
//            button.titleLabel?.font = .systemFont(ofSize: 10, weight: .bold)
//            button.setTitleColor(.white, for: .selected)
//            button.addTarget(self, action: #selector(selectChar), for: .touchUpInside)
//            buttons.append(button)
//        }
//
//        stackView = UIStackView(arrangedSubviews: buttons)
//
//        stackView.axis = .vertical
//        stackView.alignment = .trailing
//        stackView.distribution = .fillProportionally
//        stackView.contentMode = .scaleAspectFill
//
//        addSubview(stackView)
//    }
    
    func setupUI() {
            buttons.removeAll()
            
            for char in Chars! {
                let button = UIButton(type: .system)
                button.setTitle(char, for: .normal)
                button.setTitleColor(.systemBlue, for: .normal)
                button.setTitleColor(.white, for: .selected)
                button.titleLabel?.font = .systemFont(ofSize: 10, weight: .bold)
                button.addTarget(self, action: #selector(selectChar), for: .touchUpInside)
                buttons.append(button)
            }
            
            if stackView != nil {
                stackView.removeFullyAllArrangedSubviews()
            }
            
            
            stackView = UIStackView(arrangedSubviews: buttons)
            addSubview(stackView)
            
            stackView.axis = .vertical
            stackView.alignment = .trailing
            stackView.distribution = .fillProportionally
            stackView.contentMode = .scaleAspectFit
    }

    @objc func selectChar(_ sender: UIButton) {
        guard let index = buttons.firstIndex(of: sender),
              let char: String = Chars?[index] else { return }
        selectedChar = char
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.heightAnchor.constraint(equalToConstant: 300).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        stackView.frame = bounds
    }
}
