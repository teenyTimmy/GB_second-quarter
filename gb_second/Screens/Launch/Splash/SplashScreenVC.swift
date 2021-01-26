//
//  SplashScreenVC.swift
//  gb_second
//
//  Created by Artem Fedorchenko on 1/25/21.
//

import UIKit

class SplashScreenVC: UIViewController {
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var firstImage: UIImageView!
    @IBOutlet weak var secondImage: UIImageView!
    @IBOutlet weak var thirdImage: UIImageView!
    
    private let imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        
        imageView.image = UIImage(named: "WhiteLogo")
        
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(imageView)
        
        UIView.animateKeyframes(
            withDuration: 0.8,
            delay: 0,
            options: [.repeat, .autoreverse]
        ) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                self.firstImage.alpha = 0.8
            })
            UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 0.5, animations: {
                self.secondImage.alpha = 0.8
            })
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.5, animations: {
                self.thirdImage.alpha = 0.8
            })
        }
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.center = view.center
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            UIView.animateKeyframes(
                withDuration: 0.6,
                delay: 0,
                options: [],
                animations: {
                    self.container.alpha = 0
                    
                },
                completion: { end in
                    if end {
                        self.animate()
                    }
            })
        })
    }

    private func animate() {
        UIView.animate(withDuration: 1, animations: {
            let size = self.view.frame.size.width * 3
            let diffX = size - self.view.frame.size.width
            let diffY = self.view.frame.size.height - size
            
            self.imageView.frame = CGRect(
                x: -(diffX / 2),
                y: diffY / 2,
                width: size,
                height: size
            )
        })
        
        UIView.animate(withDuration: 1.5, animations: {
            self.imageView.alpha = 0
        }, completion: { end in
            if end {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {guard let viewController = UIStoryboard(name: "Login", bundle: nil).instantiateInitialViewController() else { return }
                    
                    viewController.modalTransitionStyle = .crossDissolve
                    viewController.modalPresentationStyle = .fullScreen
                    self.present(viewController, animated: true, completion: nil)
                })
            }
        })
    }
}
