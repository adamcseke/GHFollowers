//
//  SearchViewController.swift
//  GHFollowers
//
//  Created by Adam Cseke on 2022. 02. 04..
//

import UIKit
import SnapKit

class SearchViewController: UIViewController {
    
    private var followersButton: Button!
    private var textfield: Textfield!
    private var logoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.isHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        self.hideKeyboardWhenTappedAround()
        setup()
        
    }
    private func setup() {
        configureLogoImageView()
        configureTextfield()
        configureGetFollowersButton()
    }
    
    private func configureLogoImageView() {
        logoImageView = UIImageView()
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "gh-logo")
        logoImageView.contentMode = .scaleAspectFill
        logoImageView.layer.masksToBounds = true
        view.addSubview(logoImageView)
        
        logoImageView.snp.makeConstraints({ make in
            make.width.height.equalTo(220)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.60)
        })
    }
    
    private func configureTextfield() {
        textfield = Textfield()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.customDelegate = self
        textfield.returnKeyType = .search
        
        view.addSubview(textfield)
        
        textfield.snp.makeConstraints({ make in
            make.height.equalTo(62)
            make.leading.equalTo(31)
            make.centerX.equalToSuperview()
            make.top.equalTo(logoImageView.snp.bottom).offset(53)
        })
    }
    
    private func configureGetFollowersButton() {
        followersButton = Button()
        followersButton.setButtonType(buttonType: ButtonType.followers)
        followersButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(followersButton)
        
        followersButton.snp.makeConstraints({ make in
            make.height.equalTo(62)
            make.leading.equalTo(31)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(1.60)
        })
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}

extension SearchViewController: TextfieldDelegate {
    func textfieldDidChange(text: String) {
        print(text)
    }
}
