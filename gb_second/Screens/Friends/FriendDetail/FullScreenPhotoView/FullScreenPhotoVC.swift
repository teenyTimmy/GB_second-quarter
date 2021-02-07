//
//  FullScreenPhotoVC.swift
//  gb_second
//
//  Created by Artem Fedorchenko on 1/31/21.
//

import UIKit

class FullScreenPhotoVC: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var images: [String]?
    var indexPath: IndexPath!
    private let countCells: Int = 1
    private let reuseIdentifier: String = "FullScreenPhotoViewCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "FullScreenPhotoViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.performBatchUpdates(nil) { res in
            self.collectionView.scrollToItem(at: self.indexPath, at: .centeredHorizontally, animated: false)
        }
    }
}

extension FullScreenPhotoVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let images = images else { return 1 }
    
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? FullScreenPhotoViewCell else { return UICollectionViewCell() }
        
        cell.imageView.image = UIImage(named: images![indexPath.row])
        cell.imageView.clipsToBounds = true
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let frameCV = collectionView.frame
        let widthCell = frameCV.width / CGFloat(countCells)
        let heightCell = widthCell
        
        return CGSize(width: widthCell, height: heightCell)
    }
}
