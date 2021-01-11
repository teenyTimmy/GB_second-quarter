//
//  UserFriendsVC.swift
//  gb_second
//
//  Created by Artem Fedorchenko on 12/28/20.
//

import UIKit

class UserFriendsVC: UITableViewController {
    
    let mockFriends: [String] = ["Dom", "Paul", "HAN", "Tej", "Letti"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mockFriends.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? UserFriendsCell else { return UITableViewCell() }

        cell.userName.text = mockFriends[indexPath.row]
        cell.userImage.image = UIImage(named: mockFriends[indexPath.row])
        cell.userImage.layer.cornerRadius = cell.userImage.frame.size.height / 2
        cell.userImage.clipsToBounds = true
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "userDetail",
              let destination = segue.destination as? FriendDetailVC else { return }
        
        guard let tableViewController = segue.source as? Self,
              let indexPath = tableViewController.tableView.indexPathForSelectedRow else { return }
        
        destination.imageName = tableViewController.mockFriends[indexPath.row]
    }

}
