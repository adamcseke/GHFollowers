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
    
    private var selectedFollower: Follower?
    private var user: String?
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
    
    init(selectedFollower: Follower) {
        self.selectedFollower = selectedFollower
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
        getUserInfo(user: selectedFollower?.login ?? "")
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
    }
    
    private func getUserInfo(user: String) {
        RestClient.shared.getUserInfo(user: user) { result in
            switch result {
                
            case .success(let user):
                self.setInfos(userInfo: user)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func setInfos(userInfo: User) {
        self.username = userInfo.login
        self.company = userInfo.htmlURL
        self.userImageView.sd_setImage(with: URL(string: userInfo.avatarURL))
        self.userLoginLabel.text = userInfo.login
        self.userNameLabel.text = userInfo.name ?? ""
        self.userLocationLabel.text = userInfo.location ?? "--"
        self.userBioLabel.text = userInfo.bio ?? ""
        if userInfo.company == nil {
            self.companyView.isHidden = true
        }
        
        self.companyView.setContentViewType(contentViewType: .website, infoLabelOneText: userInfo.company ?? "",
                                            infoLabelTwoText: "")
        
        self.followersView.setContentViewType(contentViewType: .followers, infoLabelOneText: "\(userInfo.following)",
                                              infoLabelTwoText: "\(userInfo.followers)")
        
        self.githubProfileView.setContentViewType(contentViewType: .githubProfile, infoLabelOneText: "\(userInfo.publicRepos)",
                                                  infoLabelTwoText: "\(userInfo.publicGists)")
        
        self.githubSinceLabel.text = "UserInfoViewController.CreatedAt".localized + "\(userInfo.dateResult)"
    }
    
    private func configureShadowView() {
        shadowView = ShadowView()
        contentView.addSubview(shadowView)
        
        shadowView.snp.makeConstraints { make in
            make.leading.equalTo(28)
            make.top.equalTo(20)
            make.height.width.equalTo(90)
        }
    }
    
    private func configureUserImageView() {
        userImageView = UIImageView()
        userImageView.layer.cornerRadius = 12
        userImageView.clipsToBounds = true
        
        shadowView.addSubview(userImageView)
        
        userImageView.snp.makeConstraints { make in
            make.centerX.equalTo(shadowView.snp.centerX)
            make.centerY.equalTo(shadowView.snp.centerY)
            make.height.width.equalTo(shadowView.snp.width)
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
            make.leading.equalTo(34)
            make.trailing.equalTo(-16)
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
            make.leading.equalTo(contentView)
            make.trailing.equalTo(contentView)
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
                UIApplication.shared.open(url)
            }
        case .website:
            break
        }
    }
}
