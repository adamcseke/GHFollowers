//
//  InfoView.swift
//  GHFollowers
//
//  Created by Adam Cseke on 2022. 02. 17..
//

import UIKit
import SnapKit

class InfoView: UIView {
    
    private var imageView: UIImageView!
    private var titleLabel: UILabel!
    private var infoLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setup() {
        configureView()
        configureImageView()
        configureTitleLabel()
        configureInfoLabel()
    }
    
    private func configureView() {
        backgroundColor = Colors.contentViewsColors
    }
    
    private func configureImageView() {
        imageView = UIImageView()
        imageView.tintColor = Colors.userInfoLabels
        
        addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
        }
    }
    
    private func configureTitleLabel() {
        titleLabel = UILabel()
        if  UIDevice.Devices.iPhoneSE1stGen {
            titleLabel.font = .systemFont(ofSize: 15, weight: .bold)
        } else {
            titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        }
        titleLabel.textColor = Colors.userInfoLabels
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            if UIDevice.Devices.iPhoneSE1stGen {
                make.leading.equalTo(imageView.snp.trailing).offset(2)
            } else {
                make.leading.equalTo(imageView.snp.trailing).offset(5.5)
            }
            make.centerY.equalTo(imageView.snp.centerY)
        }
    }
    
    private func configureInfoLabel() {
        infoLabel = UILabel()
        infoLabel.textColor = Colors.userInfoLabels
        addSubview(infoLabel)
        
        infoLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerX.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(8)
        }
    }
    
    func bind(image: UIImage?, titleLabelText: String, infoLabelText: String, infoLabelFont: UIFont, infoLabelTextAlignment: NSTextAlignment) {
        guard let img = image else {
            return
        }
        imageView.image = img
        titleLabel.text = titleLabelText
        infoLabel.text = infoLabelText
        infoLabel.font = infoLabelFont
        infoLabel.textAlignment = infoLabelTextAlignment
    }
    
}
