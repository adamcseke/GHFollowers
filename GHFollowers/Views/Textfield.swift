//
//  Textfield.swift
//  GHFollowers
//
//  Created by Adam Cseke on 2022. 02. 07..
//

import UIKit

protocol TextfieldDelegate: AnyObject {
    func textfieldDidChange(text: String)
}

class Textfield: UITextField {
    
    weak var customDelegate: TextfieldDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        configureTextfield()
    }
    
    private func configureTextfield() {
        layer.borderColor = Colors.grayBorderColor.cgColor
        layer.borderWidth = 2
        layer.cornerRadius = 12
        textAlignment = .center
        attributedPlaceholder = NSAttributedString(string: "Textfield.Label".localized, attributes: [ .font: UIFont.boldSystemFont(ofSize: 23.0) ])
        addTarget(self, action: #selector(textfieldChanged), for: .editingChanged)
    }
    
    @objc private func textfieldChanged() {
        customDelegate?.textfieldDidChange(text: text ?? "")
    }
}
