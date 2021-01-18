//
//  TableVCExtension.swift
//  gb_second
//
//  Created by Artem Fedorchenko on 1/6/21.
//

import UIKit

extension UITableViewController {
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView(frame: .zero)
    }
}
