//
//  SettingsCell.swift
//  YouTube_Clone
//
//  Created by mac on 9/30/19.
//  Copyright © 2019 letsbuildthatapp. All rights reserved.
//

import UIKit

class SettingsCell: BaseCell {
    var setting: Setting? {
        didSet{
           
            SettingLabel.text = setting?.name
            
        
            if let imageName = setting?.image_name{
            SettingsIcon.image = UIImage(named: imageName)
                
            }
            
        }
    }
    let SettingLabel: UILabel = {
        let label = UILabel()
        label.text = "Settings"
        
        return label
    }()
    
    let SettingsIcon: UIImageView = {
        
        let icon_image = UIImageView()
        icon_image.image = UIImage(named: "Setting_Icon")
        icon_image.contentMode = .scaleAspectFill
        return icon_image
    }()
    
  override func setupViews() {
        super.setupViews()
    addSubview(SettingLabel)
        addSubview(SettingsIcon)
      
        addConstraintsWithFormat("H:|-8-[v0(30)]-8-[v1]", views: SettingsIcon,SettingLabel)
        addConstraintsWithFormat("V:|[v0]|", views: SettingLabel)
        addConstraintsWithFormat("V:[v0(30)]", views: SettingsIcon)
    
    addConstraint(NSLayoutConstraint(item: SettingsIcon, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
}
