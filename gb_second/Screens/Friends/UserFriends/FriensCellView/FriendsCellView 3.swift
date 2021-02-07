//
//  FriendsCellView.swift
//  gb_second
//
//  Created by Artem Fedorchenko on 1/21/21.
//

import UIKit

class FriendsCellView: UIView {
    @IBOutlet var mainViewContainer: UIView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configureUI()
    }
    
    private func configureUI() {
        Bundle.main.loadNibNamed("FriendsCellView", owner: self, options: nil)
        addSubview(mainViewContainer)
        mainViewContainer.frame = bounds
        mainViewContainer.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}
