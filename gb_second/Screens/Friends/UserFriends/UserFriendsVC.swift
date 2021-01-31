//
//  UserFriendsVC.swift
//  gb_second
//
//  Created by Artem Fedorchenko on 12/28/20.
//

import UIKit

class UserFriendsVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var characterPicker: CharacterPicker!
    
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
    
    private let friends: Array<[String: Any]> = [
        ["name": "Dom", "images": ["Dom", "HAN", "Fast 3", "Fast 5"]],
        ["name": "Paul", "images": ["Paul", "HAN", "Fast 1", "Fast 2", "Fast 5", "Fast 4"]],
        ["name": "HAN", "images": ["HAN", "Fast 3", "Fast 5", "Fast 4"]],
        ["name": "Tej", "images": ["Tej", "HAN", "Fast 3", "Fast 5", "Fast 1", "Fast 2"]],
        ["name": "Letti", "images": ["Letti", "HAN", "Fast 3", "Fast 5"]],
        ["name": "Ron", "images": ["Ron", "HAN", "Fast 3", "Fast 5"]],
        ["name": "Ramzey", "images": ["Dom", "HAN", "Fast 3", "Fast 5"]],
        ["name": "Mia", "images": ["Dom", "HAN", "Fast 3", "Fast 5"]],
        ["name": "Adwin", "images": ["Dom", "HAN", "Fast 3", "Fast 5"]],
        ["name": "Johny", "images": ["Dom", "HAN", "Fast 3", "Fast 5"]],
        ["name": "Tago", "images": ["Dom", "HAN", "Fast 3", "Fast 5"]],
    ]
    
    private let searchController: UISearchController! = UISearchController(searchResultsController: nil)
    private var selectedFriend: String = ""
    private var tableSections: [String] = [String]()
    private var filteredResults: [String] = [String]()
    private var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.tintColor = .systemBlue
        definesPresentationContext = true
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        
        createSectionsHandler()
        
        characterPicker.Chars = tableSections
        characterPicker.setupUI()        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "userDetail",
              let destination = segue.destination as? FriendDetailVC else { return }
        
        guard let tableViewController = segue.source as? Self,
              let indexPath = tableViewController.tableView.indexPathForSelectedRow else { return }
        
        var tempArr: Array<[String]> = [[String]]()
        
        friends.forEach {
            let name = "\($0["name"]!)"
            let char = name.prefix(1)
            let images = $0["images"] as! [String]
            
            if char == tableSections[indexPath.section] {
                tempArr.append(images)
            }
        }
        
        destination.images = tempArr[indexPath.row]
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        if isFiltering {
            return 1
        }
        
        return tableSections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if isFiltering {
            updateCharsHandler()
            
            return nil
        }
        
        updateCharsHandler(arr: tableSections)
        return tableSections[section]
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredResults.count
        }
        
        var tempArr: [String] = [String]()
        
        friends.forEach {
            let name = "\($0["name"]!)"
            let char = String(name.prefix(1))
            
            if char == tableSections[section]  {
                tempArr.append(name)
            }
        }
        
        return tempArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? UserFriendsCell else { return UITableViewCell() }
        let cellView: FriendsCellView = FriendsCellView()
        cellView.frame = cell.viewCell.bounds
        
        if isFiltering {
            cellView.userName.text = filteredResults[indexPath.row]
            cellView.userImage.image = getUserImage(named: filteredResults[indexPath.row])
        } else {
            var tempArr: [String] = [String]()
            
            friends.forEach {
                let name = "\($0["name"]!)"
                let char = name.prefix(1)
                
                if char == tableSections[indexPath.section] {
                    tempArr.append(name)
                }
            }
            
            cellView.userName.text = String(tempArr[indexPath.row])
            cellView.userImage.image = getUserImage(named: tempArr[indexPath.row])
        }
        
        cell.addSubview(cellView)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func getUserImage(named: String) -> UIImage {
        guard let image = UIImage(named: named) else { return UIImage(named: "NoPhoto")! }
        
        return image
    }
    
    func createSectionsHandler() -> Void {
        friends.forEach {
            let name = "\($0["name"]!)"
            let char = String(name.prefix(1))
            
            if tableSections.contains(char) { return }
            
            tableSections.append(char)
        }
        
        tableSections.sort(by: <)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredResults = getUsers().filter { (user: String) -> Bool in
            return user.lowercased().contains(searchText.lowercased())
        }

        tableView.reloadData()
    }
    
    func updateCharsHandler(arr: [String] = []) {
        characterPicker.Chars = arr
        characterPicker.setupUI()
    }
    
    func getUsers() -> Array<String> {
        var tempArr: [String] = [String]()
        
        friends.forEach {
            let name = "\($0["name"]!)"
            tempArr.append(name)
        }
        
        return tempArr
    }
}
