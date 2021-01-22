//
//  GlobalGroupsVC.swift
//  gb_second
//
//  Created by Artem Fedorchenko on 12/28/20.
//

import UIKit

class GroupsGlobalSearchVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let mockGroups: [String] = ["Fast 1", "Fast 2", "Fast 3", "Fast 4", "Fast 5", "Fast 6", "Fast 7", "Fast 8"]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Global search"
        searchController.searchBar.tintColor = .systemBlue
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mockGroups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? GlobalGroupCell else { return UITableViewCell() }

        cell.groupName.text = mockGroups[indexPath.row]
        cell.groupImage.image = UIImage(named: mockGroups[indexPath.row])
        cell.groupImage.layer.cornerRadius = cell.groupImage.frame.size.height / 2
        cell.groupImage.clipsToBounds = true
        
        return cell
    }
    
}
