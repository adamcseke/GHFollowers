//
//  Button.swift
//  GHFollowers
//
//  Created by Adam Cseke on 2022. 02. 07..
//

import UIKit

enum ButtonType {
    case followers
    case githubProfile
    case website
}

class Button: UIControl {
    
    private var buttonLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        configureButton()
        configureLabel()
    }
    
    private func configureButton() {
        layer.cornerRadius = 10
        addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    @objc private func didTapButton() {
        print("BUTTON TAPPED")
    }
    
    private func configureLabel() {
        buttonLabel = UILabel()
        
        buttonLabel.textColor = .white
        buttonLabel.font = .systemFont(ofSize: 20)
        buttonLabel.textAlignment = .center
        
        buttonLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(buttonLabel)
        
        NSLayoutConstraint.activate([
            buttonLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            buttonLabel.topAnchor.constraint(equalTo: topAnchor),
            buttonLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            buttonLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func setButtonType(buttonType: ButtonType) {
        
        switch buttonType {
        case .followers:
            backgroundColor = Colors.green
            buttonLabel.text = "ButtonTitleLabel.GF".localized
            buttonLabel.font = .systemFont(ofSize: 20, weight: .medium)
        case .githubProfile:
            backgroundColor = Colors.purple
            buttonLabel.text = "ButtonTitleLabel.GP".localized
            buttonLabel.font = .systemFont(ofSize: 20, weight: .bold)
        case .website:
            backgroundColor = Colors.red
            buttonLabel.text = "ButtonTitleLabel.WS".localized
            buttonLabel.font = .systemFont(ofSize: 20, weight: .bold)
        }
    }
}
