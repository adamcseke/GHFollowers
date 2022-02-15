//
//  AlertViewController.swift
//  GHFollowers
//
//  Created by Adam Cseke on 2022. 02. 11..
//

import UIKit
import SnapKit

class AlertViewController: UIViewController {
    
    private var containerView: UIView!
    private var titleLabel: UILabel!
    private var messageLabel: UILabel!
    private var actionButton: Button!
    
    var alertTitle: String?
    var message: String?
    
    init(title: String, message: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = title
        self.message = message
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        configureViewController()
        configureContainerView()
        configureTitleLabel()
        configureMessageLabel()
        configureActionButton()
        view.backgroundColor = .black.withAlphaComponent(0.75)
    }
    
    private func configureViewController() {
        view.backgroundColor = .clear
    }
    
    private func configureContainerView() {
        containerView = UIStackView()
        containerView.layer.cornerRadius = 16
        containerView.backgroundColor = .systemBackground
        view.addSubview(containerView)
        
        containerView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    private func configureTitleLabel() {
        titleLabel = UILabel()
        titleLabel.textColor = Colors.alertTitle
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        titleLabel.text = alertTitle ?? ""
        containerView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.leading.equalToSuperview().offset(28)
            make.centerX.equalToSuperview()
        }
    }
    
    private func configureMessageLabel() {
        messageLabel = UILabel()
        messageLabel.numberOfLines = 4
        messageLabel.textAlignment = .center
        messageLabel.textColor = Colors.userInfoLabels
        messageLabel.text = message ?? ""
        messageLabel.font = .systemFont(ofSize: 14, weight: .regular)
        containerView.addSubview(messageLabel)
        
        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(28)
            make.leading.equalToSuperview().offset(26)
            make.centerX.equalToSuperview()
        }
    }
    
    private func configureActionButton() {
        actionButton = Button()
        actionButton.setButtonType(buttonType: .alert)
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        containerView.addSubview(actionButton)
        
        actionButton.snp.makeConstraints { make in
            make.top.equalTo(messageLabel.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(40)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
            make.width.equalTo(200)
            make.height.equalTo(44)
        }
    }
    
    @objc private func dismissVC() {
        dismiss(animated: true)
    }
}
