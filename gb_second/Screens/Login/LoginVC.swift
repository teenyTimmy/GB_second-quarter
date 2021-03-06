//
//  ViewController.swift
//  gb_second
//
//  Created by Artem Fedorchenko on 12/24/20.
//

import UIKit

class LoginVC: UIViewController, UIScrollViewDelegate {
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var loginTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    let gradientLayer = CAGradientLayer()
    let darkGreen = UIColor("#0e4b3b")!
    let easyGreen = UIColor("#11814C")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTapGestureToHideKeyboard()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )

        gradientLayer.colors = [easyGreen.cgColor, darkGreen.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.6, y: 0.4)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.8)
        gradientLayer.frame = view.bounds

        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    override func viewDidLayoutSubviews() {
        gradientLayer.frame = view.bounds
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        let networkManager = NetworkManager.shared
        let result = networkManager.login(email: loginTextfield.text!, password: passwordTextfield.text!)
        
        
        if !result {
            showAlert()
            return result
        }
        
        return result
    }
    
    func addTapGestureToHideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(view.endEditing))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        guard let keyboardSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.size.height, right: 0)
        scrollView.contentInset = insets
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        scrollView.contentInset = UIEdgeInsets.zero
    }
    
    func showAlert() {
        let alert = UIAlertController(
            title: "Error",
            message: "Username or Password has incorrect",
            preferredStyle: .alert
        )
        let alertAction = UIAlertAction(title: "Close", style: .cancel, handler: nil)
        
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
}
