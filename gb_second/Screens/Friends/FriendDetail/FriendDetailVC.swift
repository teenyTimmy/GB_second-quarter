//
//  UserFriendDetailVC.swift
//  gb_second
//
//  Created by Artem Fedorchenko on 12/28/20.
//

import UIKit



class FriendDetailVC: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var images: [String]?
    private let countCells: Int = 3
    private let offset: CGFloat = 2.0
    private let reuseIdentifier: String = "Cell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "PhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
    }
}


extension FriendDetailVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let images = images else { return 1 }
    
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? PhotoCollectionViewCell else { return UICollectionViewCell()}
        
        cell.imageView.image = UIImage(named: images![indexPath.row])
        cell.imageView.clipsToBounds = true
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let frameCV = collectionView.frame
        let widthCell = frameCV.width / CGFloat(countCells)
        let heightCell = widthCell
        let spacing = CGFloat(CGFloat((countCells + 1)) * offset / CGFloat(countCells))
        
        return CGSize(width: widthCell - spacing, height: heightCell - (offset * 2))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "FullScreenPhotoVC") as! FullScreenPhotoVC
        
        vc.images = images
        vc.indexPath = indexPath
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
