//
//  FavoritesCell.swift
//  GHFollowers
//
//  Created by Adam Cseke on 2022. 02. 10..
//

import UIKit
import SnapKit
import SDWebImage

class FavoritesCell: UITableViewCell {
    
    static let reuseID = "FavoriteCell"
    
    private var userImageView: UIImageView!
    private var usernameLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    func set(imageURL: String, usernameLabelText: String) {
        usernameLabel.text = usernameLabelText
        userImageView.sd_setImage(with: URL(string: imageURL))
    }
    
    private func configure() {
        userImageView = UIImageView()
        usernameLabel = UILabel()
        addSubview(userImageView)
        addSubview(usernameLabel)
        
        userImageView.layer.cornerRadius = 12
        userImageView.layer.masksToBounds = true

        accessoryType = .disclosureIndicator
        
        userImageView.snp.makeConstraints { make in
            make.height.width.equalTo(60)
            make.centerY.equalTo(snp.centerY)
            make.leading.equalTo(21)
        }
        
        usernameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(snp.centerY)
            make.leading.equalTo(userImageView.snp.trailing).offset(25)
            make.centerX.equalToSuperview()
        }
    }
    
}
