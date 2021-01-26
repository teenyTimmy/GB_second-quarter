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
    @IBOutlet weak var imageView: UIView!
    
    @IBAction func taped(_ sender: UITapGestureRecognizer) {
        self.imageView.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0, options: []) {
            self.imageView.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
    
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
