//
//  SearchViewController.swift
//  GHFollowers
//
//  Created by Adam Cseke on 2022. 02. 04..
//

import UIKit

class SearchViewController: UIViewController {

    private var getFollowersButton: Button!
    private var githubProfileButton: Button!
    private var website: Button!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setup()
        
    }
    private func setup() {
        configureGetFollowersButton()
        configureGithubProfileButton()
        configureWebsiteButton()
    }
    
    private func configureGetFollowersButton() {
        getFollowersButton = Button()
        getFollowersButton.setButtonType(buttonType: ButtonType.followers)
        getFollowersButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(getFollowersButton)
        
        NSLayoutConstraint.activate([
            getFollowersButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            getFollowersButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            getFollowersButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -85),
            getFollowersButton.heightAnchor.constraint(equalToConstant: 62)
        ])
    }
    
    private func configureGithubProfileButton() {
        githubProfileButton = Button()
        githubProfileButton.setButtonType(buttonType: ButtonType.githubProfile)
        githubProfileButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(githubProfileButton)
        
        NSLayoutConstraint.activate([
            githubProfileButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            githubProfileButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            githubProfileButton.bottomAnchor.constraint(equalTo: getFollowersButton.topAnchor, constant: -30),
            githubProfileButton.heightAnchor.constraint(equalToConstant: 62)
        ])
    }
    
    private func configureWebsiteButton() {
        website = Button()
        website.setButtonType(buttonType: ButtonType.website)
        website.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(website)
        
        NSLayoutConstraint.activate([
            website.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            website.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            website.bottomAnchor.constraint(equalTo: githubProfileButton.topAnchor, constant: -30),
            website.heightAnchor.constraint(equalToConstant: 62)
        ])
    }


}

