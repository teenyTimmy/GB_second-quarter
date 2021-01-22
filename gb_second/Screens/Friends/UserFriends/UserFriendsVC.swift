//
//  UserFriendsVC.swift
//  gb_second
//
//  Created by Artem Fedorchenko on 12/28/20.
//

import UIKit

class UserFriendsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var characterPicker: CharacterPicker!
    
    private let mockFriends: [String] = [
        "Dom",
        "Paul",
        "HAN",
        "Tej",
        "Letti",
        "Ron",
        "Ramzey",
        "Mia",
        "Adwin",
        "Johny",
        "Tago",
    ]
    private let alphabet: [String] = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    private var tableSections: [String] = [String]()
    private var selectedFriend: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
        
        createSectionsHandler(mockFriends)
        
        characterPicker.Chars = tableSections
        characterPicker.setupUI()        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "userDetail",
              let destination = segue.destination as? FriendDetailVC else { return }
        
        guard let tableViewController = segue.source as? Self,
              let indexPath = tableViewController.tableView.indexPathForSelectedRow else { return }
        
        var tempArr = [String]()
        for user in mockFriends {
            if user.prefix(1) == tableSections[indexPath.section] {
                tempArr.append(user)
            }
        }
        
        destination.imageName = tempArr[indexPath.row]
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return tableSections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableSections[section]
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var tempArr = [String]()
        for user in mockFriends {
            if user.prefix(1) == tableSections[section] {
                tempArr.append(user)
            }
        }
        
        return tempArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? UserFriendsCell else { return UITableViewCell() }
        
        var tempArr = [String]()
        for user in mockFriends {
            if user.prefix(1) == tableSections[indexPath.section] {
                tempArr.append(user)
            }
        }

        cell.userName.text = tempArr[indexPath.row]
        cell.userImage.image = getUserImage(named: tempArr[indexPath.row])
        cell.userImage.layer.cornerRadius = cell.userImage.frame.size.height / 2
        cell.userImage.clipsToBounds = true
        
        return cell
    }
    
    func getUserImage(named: String) -> UIImage {
        guard let image = UIImage(named: named) else { return UIImage(named: "NoPhoto")! }
        
        return image
    }
    
    func createSectionsHandler(_ arr: [String]) -> Void {
        for user in arr {
            let char = user.prefix(1)
            if tableSections.contains(String(char)) { continue }
            tableSections.append(String(char))
        }
        tableSections.sort(by: <)
    }
    
    @IBAction func characterPicked(_ sender: CharacterPicker) {
        let selectedChar = characterPicker.selectedChar
        var indexPath: IndexPath = IndexPath(item: 0, section: 0)
        for (index, section) in tableSections.enumerated() {
            if selectedChar == section {
                indexPath = IndexPath(item: 0, section: index)
            }
        }
        
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    
    @IBAction func didMakePan(_ sender: UIPanGestureRecognizer) {
        let location = sender.location(in: characterPicker)
        let cf = Int(characterPicker.frame.height) / tableSections.count
        let letterIndex = Int(location.y) / cf
        
        if letterIndex < tableSections.count && letterIndex >= 0 {
            characterPicker.selectedChar = tableSections[letterIndex]
        }
        
    }
}
