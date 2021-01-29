//
//  UserFriendDetailVC.swift
//  gb_second
//
//  Created by Artem Fedorchenko on 12/28/20.
//

import UIKit

private let reuseIdentifier = "Cell"

class FriendDetailVC: UICollectionViewController {
    var images: [String]?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let images = images else { return 1 }
    
        return images.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Collection", for: indexPath) as? FriendDetailCollection else { return UICollectionViewCell()}
        
        
        
    
        cell.userImageDetail.image = UIImage(named: images![indexPath.row])
        cell.userImageDetail.clipsToBounds = true
        
        return cell
    }

}
