//
//  NewsCellView.swift
//  gb_second
//
//  Created by Artem Fedorchenko on 1/19/21.
//

import UIKit

class NewsCellView: UIView {
    @IBOutlet var mainViewContainer: UIView!
    @IBOutlet weak var authorImage: UIImageView!
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var appendTime: UILabel!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var bodyViewContainer: UIView!
    @IBOutlet weak var bottomViewControlls: UIView!
    @IBOutlet weak var viewsCount: UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configureUI()
    }
    
    private func configureUI() {
        Bundle.main.loadNibNamed("NewsCellView", owner: self, options: nil)
        addSubview(mainViewContainer)
        mainViewContainer.frame = bounds
        mainViewContainer.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}
