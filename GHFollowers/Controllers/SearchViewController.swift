//
//  SearchViewController.swift
//  GHFollowers
//
//  Created by Adam Cseke on 2022. 02. 04..
//

import UIKit
import SnapKit
import SDCAlertView

class SearchViewController: UIViewController {
    
    private var followersButton: Button!
    private var textfield: Textfield!
    private var logoImageView: UIImageView!
    private var alertView: AlertViewController!
    
    private var followers: [Follower] = []
    private var username: String?
    private var page: Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        self.hideKeyboardWhenTappedAround()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = false
    }
    
    private func setup() {
        configureLogoImageView()
        configureTextfield()
        configureGetFollowersButton()
    }
    
    private func getFollowers(user: String, page: Int) {
        RestClient.shared.getFollowers(user: user, page: page) { result in
            switch result {
                
            case .success(let follower):
                self.followers = follower
                self.pushFollowersListVC()
            case .failure(let error):
                self.configureAlertView()
                print(error.localizedDescription)
                return
            }
        }
    }
    
    private func configureAlertView() {
        alertView = AlertViewController(title: "SearchViewController.AlertTitle".localized, message: "SearchViewController.MessageText".localized)
        alertView.modalPresentationStyle = .overFullScreen
        alertView.modalTransitionStyle = .crossDissolve
        alertView.providesPresentationContextTransitionStyle = true
        navigationController?.present(alertView, animated: true)
    }
    
    private func configureLogoImageView() {
        logoImageView = UIImageView()
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
        textfield.customDelegate = self
        textfield.delegate = self
        textfield.returnKeyType = .search
        textfield.autocapitalizationType = .none
        textfield.autocorrectionType = .no
        textfield.addTarget(self, action: #selector(getFollowersData), for: .editingDidEndOnExit)
        
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
        followersButton.addTarget(self, action: #selector(getFollowersData), for: .touchUpInside)
        view.addSubview(followersButton)
        
        followersButton.snp.makeConstraints({ make in
            make.height.equalTo(62)
            make.leading.equalTo(31)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(1.60)
        })
    }
    
    @objc private func pushFollowersListVC() {
        let followersListVC = FollowerListViewController(username: self.textfield.text ?? "")
        self.navigationController?.pushViewController(followersListVC, animated: true)
    }
    
    @objc private func getFollowersData() {
        getFollowers(user: self.username ?? "", page: self.page ?? 0)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height * 0.30
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
        guard let text = textfield.text, !text.isEmpty else {
            return
        }
        self.username = text
        self.page = 1
        print(text)
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.becomeFirstResponder()
        return true
    }
}
