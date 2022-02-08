//
//  SearchViewController.swift
//  GHFollowers
//
//  Created by Adam Cseke on 2022. 02. 04..
//

import UIKit

class SearchViewController: UIViewController {
    
    private var followersButton: Button!
    private var textfield: Textfield!
    private var logoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.isHidden = true
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
        logoImageView.layer.masksToBounds = true
        view.addSubview(logoImageView)
        
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 105),
            logoImageView.heightAnchor.constraint(equalToConstant: 220),
            logoImageView.widthAnchor.constraint(equalToConstant: 220)
        ])
    }
    
    private func configureTextfield() {
        textfield = Textfield()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.customDelegate = self
        textfield.returnKeyType = .search
        
        view.addSubview(textfield)
        
        NSLayoutConstraint.activate([
            textfield.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 31),
            textfield.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textfield.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 53),
            textfield.heightAnchor.constraint(equalToConstant: 62)
        ])
    }
    
    private func configureGetFollowersButton() {
        followersButton = Button()
        followersButton.setButtonType(buttonType: ButtonType.followers)
        followersButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(followersButton)
        
        NSLayoutConstraint.activate([
            followersButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 31),
            followersButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            followersButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -36),
            followersButton.heightAnchor.constraint(equalToConstant: 62)
        ])
    }
}

extension SearchViewController: TextfieldDelegate {
    func textfieldDidChange(text: String) {
        print(text)
    }
}
