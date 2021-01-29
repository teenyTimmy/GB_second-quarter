//
//  UserGroupsVC.swift
//  gb_second
//
//  Created by Artem Fedorchenko on 12/28/20.
//

import UIKit

class UserGroupsVC: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var userGroups: [String] = []

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userGroups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? UserGroupCell else { return UITableViewCell()}
        
        cell.groupName.text = userGroups[indexPath.row]
        cell.groupImage.image = UIImage(named: userGroups[indexPath.row])
        cell.groupImage.layer.cornerRadius = cell.groupImage.frame.size.width / 2
        cell.groupImage.clipsToBounds = true
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            userGroups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    @IBAction func unwindFromGroupsGlobalSearchVC(_ segue: UIStoryboardSegue) {
        guard let globalGroupsVC = segue.source as? GroupsGlobalSearchVC,
              let indexPath = globalGroupsVC.tableView.indexPathForSelectedRow else { return }
        
        let selectedGroup = globalGroupsVC.mockGroups[indexPath.row]
        
        if userGroups.contains(selectedGroup) { return }
        
        userGroups.append(selectedGroup)
        
        tableView.reloadData()
    }
}
