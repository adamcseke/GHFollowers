//
//  Button.swift
//  GHFollowers
//
//  Created by Adam Cseke on 2022. 02. 07..
//

import UIKit
import SnapKit

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
    }
    
    private func configureLabel() {
        buttonLabel = UILabel()
        
        buttonLabel.textColor = .white
        buttonLabel.font = .systemFont(ofSize: 20)
        buttonLabel.textAlignment = .center
        buttonLabel.font = .systemFont(ofSize: 20, weight: .bold)
        
        addSubview(buttonLabel)
        
        buttonLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func bind(buttonBackgorundColor: UIColor, buttonLabelText: String, font: UIFont) {
        backgroundColor = buttonBackgorundColor
        buttonLabel.text = buttonLabelText
        buttonLabel.font = font
    }
}
