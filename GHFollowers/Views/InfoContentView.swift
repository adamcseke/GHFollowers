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
    
    private var companyImageBackgroundView: UIView!
    private var companyImageView: UIImageView!
    private var infoStackView: UIStackView!
    private var infoViewOne: InfoView!
    private var infoViewTwo: InfoView!
    
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
        configureButton()
        configureInfoStackView()
        configureInfoViewOne()
        configureInfoViewTwo()
        configureCompanyImageView()
    }

    private func configureView() {
        backgroundColor = Colors.contentViewsColors
        layer.cornerRadius = 20
        
        snp.makeConstraints { make in
            make.height.equalTo(151)
        }
    }
    
    private func configureInfoStackView() {
        infoStackView = UIStackView()
        infoStackView.axis = .horizontal
        infoStackView.alignment = .fill
        infoStackView.distribution = .equalCentering
        addSubview(infoStackView)
        
        infoStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(23.5)
            make.top.equalToSuperview().offset(17)
            make.bottom.equalTo(button.snp.top).offset(-24)
            make.centerX.equalToSuperview()
        }
    }
    
    private func configureInfoViewOne() {
        infoViewOne = InfoView()
        infoStackView.addArrangedSubview(infoViewOne)
        
        infoViewOne.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalTo(snp.centerX)
            make.bottom.equalToSuperview()
        }
    }
    
    private func configureInfoViewTwo() {
        infoViewTwo = InfoView()
        infoStackView.addArrangedSubview(infoViewTwo)
        
        infoViewTwo.snp.makeConstraints { make in
            make.leading.equalTo(infoViewOne.snp.trailing)
            
            make.bottom.equalToSuperview()
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
        companyImageBackgroundView = UIView()
        addSubview(companyImageBackgroundView)
        companyImageBackgroundView.addSubview(companyImageView)
        
        companyImageBackgroundView.layer.cornerRadius = 13
        
        companyImageBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(13)
            make.trailing.equalTo(-25)
            make.height.width.equalTo(60)
        }
        
        companyImageView.snp.makeConstraints { make in
            make.centerX.equalTo(companyImageBackgroundView.snp.centerX)
            make.centerY.equalTo(companyImageBackgroundView.snp.centerY)
        }
    }
    
    func setContentViewType(contentViewType: ContentViewType, infoLabelOneText: String, infoLabelTwoText: String) {
        viewType = contentViewType
        
        switch contentViewType {
            
        case .followers:
            button.bind(buttonBackgorundColor: Colors.green, buttonLabelText: "ButtonTitleLabel.GF".localized, font: .systemFont(ofSize: 20, weight: .bold))
            
            
            
            infoViewOne.bind(image: UIImage(systemName: "heart", withConfiguration: boldConfiguration),
                          titleLabelText: "InfoContentView.Followers.TitleLabelOne".localized,
                          infoLabelText: infoLabelOneText,
                          infoLabelFont: .systemFont(ofSize: 18, weight: .bold),
                             infoLabelTextAlignment: .center)
            
            infoViewTwo.bind(image: UIImage(systemName: "person.2", withConfiguration: boldConfiguration),
                             titleLabelText: "InfoContentView.Followers.TitleLabelTwo".localized,
                             infoLabelText: infoLabelTwoText,
                             infoLabelFont: .systemFont(ofSize: 18, weight: .bold),
                             infoLabelTextAlignment: .center)
            
            companyImageBackgroundView.isHidden = true
            
        case .githubProfile:
            button.bind(buttonBackgorundColor: Colors.purple, buttonLabelText: "ButtonTitleLabel.GP".localized, font: .systemFont(ofSize: 20, weight: .bold))
            
            infoViewOne.bind(image: UIImage(systemName: "folder", withConfiguration: boldConfiguration),
                          titleLabelText: "InfoContentView.GithubProfile.TitleLabelOne".localized,
                          infoLabelText: infoLabelOneText,
                          infoLabelFont: .systemFont(ofSize: 18, weight: .bold),
                             infoLabelTextAlignment: .center)
            
            infoViewTwo.bind(image: UIImage(systemName: "text.alignleft", withConfiguration: boldConfiguration),
                             titleLabelText: "InfoContentView.GithubProfile.TitleLabelTwo".localized,
                             infoLabelText: infoLabelTwoText,
                             infoLabelFont: .systemFont(ofSize: 18, weight: .bold),
                             infoLabelTextAlignment: .center)
            
            companyImageBackgroundView.isHidden = true
            
        case .website:
            button.bind(buttonBackgorundColor: Colors.red, buttonLabelText: "ButtonTitleLabel.WS".localized, font: .systemFont(ofSize: 20, weight: .bold))
            
            infoViewOne.bind(image: UIImage(systemName: "person.3", withConfiguration: boldConfiguration),
                          titleLabelText: "InfoContentView.Website.TitleLabelOne".localized,
                          infoLabelText: infoLabelOneText,
                          infoLabelFont: .systemFont(ofSize: 18, weight: .regular),
                             infoLabelTextAlignment: .left)
            
            infoViewTwo.isHidden = true
            infoViewOne.snp.makeConstraints { make in
                make.trailing.equalTo(companyImageBackgroundView.snp.trailing).offset(-60)
            }
            
            companyImageBackgroundView.backgroundColor = Colors.darkGray
            companyImageView.image = UIImage(systemName: "paperplane", withConfiguration: mediumConfiguration)
            companyImageView.snp.makeConstraints { make in
                make.height.equalTo(31)
                make.width.equalTo(33)
            }
            companyImageView.tintColor = .white
        }
    }
}
