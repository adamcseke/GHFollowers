//
//  ShadowView.swift
//  GHFollowers
//
//  Created by Adam Cseke on 2022. 02. 10..
//

import UIKit

class ShadowView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        dropShadow()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        dropShadow()
    }
    
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = .zero
        layer.shadowRadius = 5
        layer.cornerRadius = 13
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
    
}
