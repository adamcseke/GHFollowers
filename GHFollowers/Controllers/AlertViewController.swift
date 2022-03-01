//
//  AlertViewController.swift
//  GHFollowers
//
//  Created by Adam Cseke on 2022. 02. 11..
//

import UIKit
import SnapKit

class AlertViewController: UIViewController {
    
    private var transparentView: UIView!
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
        initGestureRecognizer()
    }
    
    private func initGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped))
        transparentView.addGestureRecognizer(tap)
    }
    
    @objc
    private func backgroundTapped() {
        dismiss(animated: true)
    }
    
    private func setup() {
        configureViewController()
        configureTransparentView()
        configureContainerView()
        configureTitleLabel()
        configureMessageLabel()
        configureActionButton()
        view.backgroundColor = .black.withAlphaComponent(0.75)
    }
    
    private func configureViewController() {
        view.backgroundColor = .clear
    }
    
    private func configureTransparentView() {
        transparentView = UIView()
        
        view.addSubview(transparentView)
        transparentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func configureContainerView() {
        containerView = UIStackView()
        containerView.layer.cornerRadius = 16
        containerView.backgroundColor = .systemBackground
        view.addSubview(containerView)
        
        containerView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.lessThanOrEqualToSuperview().multipliedBy(0.9)
        }
    }
    
    private func configureTitleLabel() {
        titleLabel = UILabel()
        titleLabel.textColor = Colors.alertTitle
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2
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
        messageLabel.numberOfLines = 0
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
        actionButton.bind(buttonBackgorundColor: Colors.red, buttonLabelText: "ButtonTitleLabel.Alert".localized, font: .systemFont(ofSize: 20, weight: .bold))
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
