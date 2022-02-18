//
//  UserInfoViewController.swift
//  GHFollowers
//
//  Created by Adam Cseke on 2022. 02. 09..
//

import UIKit
import SnapKit
import SDWebImage
import TBEmptyDataSet
import SafariServices

class UserInfoViewController: UIViewController {
    
    private var scrollView: UIScrollView!
    private var contentView: UIView!
    
    private var selectedUser: User?
    
    private var username: String?
    private var company: String?
    
    private var shadowView: ShadowView!
    private var userImageView: UIImageView!
    private var userLoginLabel: UILabel!
    private var userNameLabel: UILabel!
    private var userLocationImageView: UIImageView!
    private var userLocationLabel: UILabel!
    private var userBioLabel: UILabel!
    private var infoStackView: UIStackView!
    private var companyView: InfoContentView!
    private var followersView: InfoContentView!
    private var githubProfileView: InfoContentView!
    private var githubSinceLabel: UILabel!
    private var alertView: AlertViewController!
    
    private var isFavorite: Bool = false
    private var deleted: Bool = true
    private var inserted: Bool = false
    
    init(selectedUser: User) {
        self.selectedUser = selectedUser
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.backgroundColor = .systemBackground
        navigationController?.navigationBar.isOpaque = true
        navigationItem.largeTitleDisplayMode = .never
        tabBarController?.tabBar.isHidden = true
        isFavorite = isInTheFavorites(name: username ?? "")
        changeFavoriteButton(isFavorite: isFavorite)
    }
    
    private func setup() {
        configureViewController()
        configureScrollView()
        configureShadowView()
        configureUserImageView()
        configureUserLoginLabel()
        configureUserNameLabel()
        configureUserLocationImage()
        configureUserLocationLabel()
        configureUserBioLabel()
        configureInfoStackView()
        configureCompanyView()
        configureGithubProfileView()
        configureFollowersView()
        configureGithubSinceLabel()
        setInfos()
        changeFavoriteButton(isFavorite: isFavorite)
    }
    
    private func configureScrollView() {
        scrollView = UIScrollView()
        contentView = UIView()
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(scrollView)
            make.width.equalTo(scrollView.snp.width)
        }
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(didTapNavBarButton))
    }
    
    @objc private func didTapNavBarButton() {
        if self.isFavorite {
            DatabaseManager.main.delete(username: self.username?.lowercased() ?? "") { _ in
                self.isFavorite = false
                self.changeFavoriteButton(isFavorite: self.isFavorite)
            }
        } else {
            DatabaseManager.main.insert(username: self.username?.lowercased() ?? "", avatar: selectedUser?.avatarURL ?? "") { _ in
                self.isFavorite = true
                self.changeFavoriteButton(isFavorite: self.isFavorite)
            }
        }
    }
    
    private func setInfos() {
        guard let selectedUser = selectedUser else {
            return
        }
        
        self.username = selectedUser.login
        self.company = selectedUser.htmlURL
        self.userImageView.sd_setImage(with: URL(string: selectedUser.avatarURL))
        self.userLoginLabel.text = selectedUser.login
        self.userNameLabel.text = selectedUser.name ?? ""
        self.userLocationLabel.text = selectedUser.location ?? "--"
        self.userBioLabel.text = selectedUser.bio ?? ""
        if selectedUser.company == nil {
            self.companyView.isHidden = true
        }
        
        self.companyView.setContentViewType(contentViewType: .website, infoLabelOneText: selectedUser.company ?? "",
                                            infoLabelTwoText: "")
        
        self.followersView.setContentViewType(contentViewType: .followers, infoLabelOneText: "\(selectedUser.following)",
                                              infoLabelTwoText: "\(selectedUser.followers)")
        
        self.githubProfileView.setContentViewType(contentViewType: .githubProfile, infoLabelOneText: "\(selectedUser.publicRepos)",
                                                  infoLabelTwoText: "\(selectedUser.publicGists)")
        
        self.githubSinceLabel.text = "UserInfoViewController.CreatedAt".localized + "\(selectedUser.dateResult)"
    }
    
    private func configureShadowView() {
        shadowView = ShadowView()
        contentView.addSubview(shadowView)
        
        if UIDevice.Devices.iPad {
            shadowView.snp.makeConstraints { make in
                make.centerX.equalToSuperview().multipliedBy(0.5)
                make.top.equalTo(150)
                make.height.width.equalTo(90)
            }
        } else {
            shadowView.snp.makeConstraints { make in
                make.leading.equalTo(28)
                make.top.equalTo(20)
                make.height.width.equalTo(90)
            }
        }
    }
        
    private func configureUserImageView() {
        userImageView = UIImageView()
        userImageView.layer.cornerRadius = 12
        userImageView.clipsToBounds = true
        
        shadowView.addSubview(userImageView)
        
        userImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func configureUserLoginLabel() {
        userLoginLabel = UILabel()
        userLoginLabel.font = .systemFont(ofSize: 30, weight: .bold)
        userLoginLabel.textColor = Colors.userInfoLogin
        contentView.addSubview(userLoginLabel)
        
        userLoginLabel.snp.makeConstraints { make in
            make.top.equalTo(userImageView.snp.top)
            make.leading.equalTo(userImageView.snp.trailing).offset(16)
            make.trailing.equalTo(-16)
        }
    }
    
    private func configureUserNameLabel() {
        userNameLabel = UILabel()
        userNameLabel.font = .systemFont(ofSize: 18, weight: .regular)
        userNameLabel.textColor = Colors.userInfoLabels
        contentView.addSubview(userNameLabel)
        
        userNameLabel.snp.makeConstraints { make in
            make.top.equalTo(userLoginLabel.snp.bottom).offset(5)
            make.leading.equalTo(userImageView.snp.trailing).offset(16)
        }
    }
    
    private func configureUserLocationImage() {
        userLocationImageView = UIImageView()
        userLocationImageView.image = UIImage(systemName: "mappin.and.ellipse")
        userLocationImageView.tintColor = Colors.userInfoLogin
        contentView.addSubview(userLocationImageView)
        
        userLocationImageView.snp.makeConstraints { make in
            make.leading.equalTo(userImageView.snp.trailing).offset(16)
            make.bottom.equalTo(userImageView.snp.bottom).inset(2)
            make.height.equalTo(userLocationImageView.snp.width)
        }
        
    }
    
    private func configureUserLocationLabel() {
        userLocationLabel = UILabel()
        
        userLocationLabel.font = .systemFont(ofSize: 18, weight: .regular)
        contentView.addSubview(userLocationLabel)
        userLocationLabel.textColor = Colors.userInfoLabels
        userLocationLabel.snp.makeConstraints { make in
            make.leading.equalTo(userLocationImageView.snp.trailing).offset(5)
            make.trailing.equalTo(-18)
            make.bottom.equalTo(userImageView.snp.bottom)
        }
    }
    
    private func configureUserBioLabel() {
        userBioLabel = UILabel()
        userBioLabel.font = .systemFont(ofSize: 14, weight: .regular)
        userBioLabel.textColor = Colors.userInfoLabels
        userBioLabel.numberOfLines = 3
        contentView.addSubview(userBioLabel)
        
        userBioLabel.snp.makeConstraints { make in
            make.top.equalTo(userImageView.snp.bottom).offset(16)
            make.leading.equalTo(userImageView.snp.leading).offset(6)
            make.centerX.equalToSuperview()
        }
    }
    
    private func configureInfoStackView() {
        infoStackView = UIStackView()
        infoStackView.axis = .vertical
        infoStackView.spacing = 16
        infoStackView.alignment = .center
        infoStackView.distribution = .equalSpacing
        contentView.addSubview(infoStackView)
        
        infoStackView.snp.makeConstraints { make in
            make.top.equalTo(userBioLabel.snp.bottom).offset(25)
            if UIDevice.Devices.iPad {
                make.leading.equalTo(contentView).offset(140)
            } else {
                make.leading.equalTo(contentView)
            }
            make.centerX.equalToSuperview()
        }
    }
    
    private func configureCompanyView() {
        companyView = InfoContentView()
        companyView.customButtonDelegate = self
        infoStackView.addArrangedSubview(companyView)
        
        companyView.snp.makeConstraints { make in
            make.leading.equalTo(14)
            make.centerX.equalTo(infoStackView.snp.centerX)
        }
    }
    
    private func configureGithubProfileView() {
        githubProfileView = InfoContentView()
        githubProfileView.customButtonDelegate = self
        infoStackView.addArrangedSubview(githubProfileView)
        
        githubProfileView.snp.makeConstraints { make in
            make.leading.equalTo(14)
            make.centerX.equalTo(infoStackView.snp.centerX)
        }
    }
    
    private func configureFollowersView() {
        followersView = InfoContentView()
        followersView.customButtonDelegate = self
        infoStackView.addArrangedSubview(followersView)
        
        followersView.snp.makeConstraints { make in
            make.leading.equalTo(14)
            make.centerX.equalTo(infoStackView.snp.centerX)
        }
    }
    
    private func configureGithubSinceLabel() {
        githubSinceLabel = UILabel()
        githubSinceLabel.textAlignment = .center
        githubSinceLabel.font = .systemFont(ofSize: 14, weight: .regular)
        contentView.addSubview(githubSinceLabel)
        
        githubSinceLabel.snp.makeConstraints { make in
            make.leading.equalTo(34)
            make.centerX.equalToSuperview()
            make.top.equalTo(infoStackView.snp.bottom).offset(10)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
    private func configureAlertView() {
        alertView = AlertViewController(title: "UserInfoViewController.AlertTitle".localized, message: "UserInfoViewController.MessageText".localized)
        alertView.modalPresentationStyle = .overFullScreen
        alertView.modalTransitionStyle = .crossDissolve
        alertView.providesPresentationContextTransitionStyle = true
        navigationController?.present(alertView, animated: true)
    }
}

extension UserInfoViewController: InfoContentViewDelegate {
    func buttonTapped(viewType: ContentViewType) {
        print(viewType)
        switch viewType {
        case .followers:
            let followerListVC = FollowerListViewController(username: username ?? "")
            navigationController?.pushViewController(followerListVC, animated: true)
        case .githubProfile:
            if let url = URL(string: self.company ?? "") {
                let safariViewController = SFSafariViewController(url: url)
                navigationController?.present(safariViewController, animated: true, completion: nil)
            }
        case .website:
            if self.selectedUser?.blog == "" {
                configureAlertView()
            } else {
                URLString.urlString = self.selectedUser?.blog
                openUserWebsite()
            }
        }
    }
}
