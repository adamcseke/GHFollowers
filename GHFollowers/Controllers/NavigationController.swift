//
//  NavigationController.swift
//  GHFollowers
//
//  Created by Adam Cseke on 2022. 02. 07..
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        setupNavigationController()
    }
    private func setupNavigationController() {
        navigationBar.isOpaque = false
        navigationBar.backgroundColor = .clear
        navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
    }
}
