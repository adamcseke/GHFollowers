//
//  EmptyView.swift
//  GHFollowers
//
//  Created by Adam Cseke on 2022. 02. 11..
//

import UIKit

class EmptyView: UIView {
    
    private var emptyImageView: UIImageView!
    private var emptyLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        configureEmptyLabel()
        configureEmptyImage()
    }
    
    private func configureEmptyLabel() {
        emptyLabel = UILabel()
        emptyLabel.text = "EmptyView.EmptyLabel".localized
        emptyLabel.numberOfLines = 2
        emptyLabel.font = .systemFont(ofSize: 28, weight: .medium)
        emptyLabel.textColor = Colors.emptyLabel
        emptyLabel.textAlignment = .center
        
        addSubview(emptyLabel)
        
        emptyLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.3)
            
        }
    }
    
    private func configureEmptyImage() {
        emptyImageView = UIImageView()
        emptyImageView.image = UIImage(named: "empty-state-logo")
        
        addSubview(emptyImageView)
        
        emptyImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview().multipliedBy(1.65)
            make.top.equalTo(emptyLabel.snp.bottom).offset(99)
            make.height.equalTo(emptyImageView.snp.width)
            
        }
    }
}
