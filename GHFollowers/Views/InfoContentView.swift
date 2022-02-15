//
//  InfoContentView.swift
//  GHFollowers
//
//  Created by Adam Cseke on 2022. 02. 09..
//

import UIKit
import SnapKit

protocol InfoContentViewDelegate: AnyObject {
    func buttonTapped(viewType: ContentViewType)
}

enum ContentViewType {
    case followers
    case githubProfile
    case website
}

class InfoContentView: UIView {
    
    weak var customButtonDelegate: InfoContentViewDelegate?
    private var viewType: ContentViewType?
    
    private var imageViewOne: UIImageView!
    private var titleLabelOne: UILabel!
    private var infoLabelOne: UILabel!
    private var imageViewTwo: UIImageView!
    private var titleLabelTwo: UILabel!
    private var infoLabelTwo: UILabel!
    private var companyImageBackgroudnView: UIView!
    private var companyImageView: UIImageView!
    
    private let boldConfiguration = UIImage.SymbolConfiguration(weight: .bold)
    private let mediumConfiguration = UIImage.SymbolConfiguration(weight: .medium)
    
    private var button: Button!
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        configureView()
        configureImageViewOne()
        configureTitleLabelOne()
        configureInfoLabelOne()
        configureImageViewTwo()
        configureTitleLabelTwo()
        configureInfoLabelTwo()
        configureButton()
        configureCompanyImageView()
    }
    
    
    private func configureView() {
        backgroundColor = Colors.contentViewsColors
        layer.cornerRadius = 20
        
        snp.makeConstraints { make in
            make.height.equalTo(151)
        }
    }
    
    private func configureImageViewOne() {
        imageViewOne = UIImageView()
        imageViewOne.tintColor = Colors.userInfoLabels
        
        addSubview(imageViewOne)
        
        imageViewOne.snp.makeConstraints { make in
            make.centerX.equalToSuperview().multipliedBy(0.25)
            make.top.equalTo(17)
        }
    }
    
    private func configureTitleLabelOne() {
        titleLabelOne = UILabel()
        titleLabelOne.font = .systemFont(ofSize: 18, weight: .bold)
        titleLabelOne.textColor = Colors.userInfoLabels
        addSubview(titleLabelOne)
        
        titleLabelOne.snp.makeConstraints { make in
            make.leading.equalTo(imageViewOne.snp.trailing).offset(5.5)
            make.centerY.equalTo(imageViewOne.snp.centerY)
            make.trailing.equalTo(snp.centerX)
        }
    }
    
    private func configureInfoLabelOne() {
        infoLabelOne = UILabel()
        infoLabelOne.textColor = Colors.userInfoLabels
        infoLabelOne.textAlignment = .center
        infoLabelOne.font = .systemFont(ofSize: 18, weight: .bold)
        addSubview(infoLabelOne)
        
        infoLabelOne.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerX.equalToSuperview().multipliedBy(0.5)
            make.top.equalTo(titleLabelOne.snp.bottom).offset(8)
        }
    }
    
    private func configureImageViewTwo() {
        imageViewTwo = UIImageView()
        imageViewTwo.tintColor = Colors.userInfoLabels
        addSubview(imageViewTwo)
        
        imageViewTwo.snp.makeConstraints { make in
            make.centerX.equalToSuperview().multipliedBy(1.20)
            make.top.equalTo(17)
        }
    }
    
    private func configureTitleLabelTwo() {
        titleLabelTwo = UILabel()
        titleLabelTwo.font = .systemFont(ofSize: 18, weight: .bold)
        titleLabelTwo.textColor = Colors.userInfoLabels
        addSubview(titleLabelTwo)
        
        titleLabelTwo.snp.makeConstraints { make in
            make.leading.equalTo(imageViewTwo.snp.trailing).offset(5.5)
            make.centerY.equalTo(imageViewTwo.snp.centerY)
            make.trailing.equalTo(-21)
        }
    }
    
    private func configureInfoLabelTwo() {
        infoLabelTwo = UILabel()
        infoLabelTwo.font = .systemFont(ofSize: 18, weight: .bold)
        infoLabelTwo.textColor = Colors.userInfoLabels
        addSubview(infoLabelTwo)
        
        infoLabelTwo.snp.makeConstraints { make in
            make.centerX.equalToSuperview().multipliedBy(1.50)
            make.top.equalTo(titleLabelTwo.snp.bottom).offset(8)
        }
    }
    
    private func configureButton() {
        button = Button()
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        addSubview(button)
        
        button.snp.makeConstraints { make in
            make.leading.equalTo(24)
            make.centerX.equalToSuperview()
            make.height.equalTo(44)
            make.bottom.equalTo(-14)
        }
    }
    
    @objc private func buttonTapped() {
        guard let viewType = viewType else {
            return
        }
        customButtonDelegate?.buttonTapped(viewType: viewType)
    }

    private func configureCompanyImageView() {
        companyImageView = UIImageView()
        companyImageBackgroudnView = UIView()
        addSubview(companyImageBackgroudnView)
        companyImageBackgroudnView.addSubview(companyImageView)
        
        companyImageBackgroudnView.layer.cornerRadius = 13
        
        companyImageBackgroudnView.snp.makeConstraints { make in
            make.top.equalTo(13)
            make.trailing.equalTo(-25)
            make.height.width.equalTo(60)
        }
        
        companyImageView.snp.makeConstraints { make in
            make.centerX.equalTo(companyImageBackgroudnView.snp.centerX)
            make.centerY.equalTo(companyImageBackgroudnView.snp.centerY)
        }
    }
    
    func setContentViewType(contentViewType: ContentViewType, infoLabelOneText: String, infoLabelTwoText: String) {
        viewType = contentViewType
        
        switch contentViewType {
            
        case .followers:
            button.setButtonType(buttonType: .followers)
            
            infoLabelOne.text = infoLabelOneText
            infoLabelTwo.text = infoLabelTwoText
            
            imageViewOne.image = UIImage(systemName: "heart", withConfiguration: boldConfiguration)
            imageViewOne.snp.makeConstraints { make in
                make.height.equalTo(24)
                make.width.equalTo(25)
            }
            titleLabelOne.text = "InfoContentView.Followers.TitleLabelOne".localized
            titleLabelTwo.text = "InfoContentView.Followers.TitleLabelTwo".localized
            
            imageViewTwo.image = UIImage(systemName: "person.2", withConfiguration: boldConfiguration)
            imageViewTwo.snp.makeConstraints { make in
                make.height.equalTo(24)
                make.width.equalTo(33)
            }
            
            companyImageBackgroudnView.backgroundColor = .clear
            companyImageView.image = UIImage(systemName: "")
            
        case .githubProfile:
            button.setButtonType(buttonType: .githubProfile)
            
            infoLabelOne.text = infoLabelOneText
            infoLabelTwo.text = infoLabelTwoText
            
            imageViewOne.image = UIImage(systemName: "folder", withConfiguration: boldConfiguration)
            
            imageViewOne.snp.makeConstraints { make in
                make.height.equalTo(24)
                make.width.equalTo(29)
            }
            titleLabelOne.text = "InfoContentView.GithubProfile.TitleLabelOne".localized
            titleLabelTwo.text = "InfoContentView.GithubProfile.TitleLabelTwo".localized
            
            imageViewTwo.image = UIImage(systemName: "text.alignleft", withConfiguration: boldConfiguration)
            imageViewTwo.snp.makeConstraints { make in
                make.height.equalTo(24)
                make.width.equalTo(27)
            }
            
            companyImageBackgroudnView.backgroundColor = .clear
            companyImageView.image = UIImage(systemName: "")
            
        case .website:
            button.setButtonType(buttonType: .website)
            
            infoLabelOne.text = infoLabelOneText
            
            imageViewOne.image = UIImage(systemName: "person.3", withConfiguration: boldConfiguration)
            imageViewOne.snp.makeConstraints { make in
                make.height.equalTo(24)
                make.width.equalTo(39)
            }
            
            imageViewTwo.image = UIImage(systemName: "")
            
            titleLabelOne.text = "InfoContentView.Website.TitleLabelOne".localized
            
            companyImageBackgroudnView.backgroundColor = Colors.darkGray
            companyImageView.image = UIImage(systemName: "paperplane", withConfiguration: mediumConfiguration)
            companyImageView.snp.makeConstraints { make in
                make.height.equalTo(31)
                make.width.equalTo(33)
            }
            companyImageView.tintColor = .white
        }
    }
}
