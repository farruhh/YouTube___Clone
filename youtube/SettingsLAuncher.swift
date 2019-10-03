//
//  SettingsLAuncher.swift
//  YouTube_Clone
//
//  Created by mac on 9/30/19.
//  Copyright © 2019 letsbuildthatapp. All rights reserved.
//

import UIKit

class Setting: NSObject {
    
    let name: String
    let image_name: String
    
    init(name:String, image_name: String) {
        self.name = name
        self.image_name = image_name
    }
}

class SettingsLauncher: NSObject, UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
     let cellid = "cellId"
    
    
    let darkView = UIView()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        
        return cv
    }()
    
    let settings: [Setting] = {
        
     return [Setting(name: "Settings", image_name: "Setting_Icon"),
             Setting(name: "Terms & Privacy Policy", image_name: "privacy_icon"), Setting(name: "Send Feedback", image_name: "feed_back_icon"), Setting(name: "Help", image_name: "help_icon"), Setting(name: "Switch Account", image_name: "switch_account_icon"), Setting(name: "Cancel", image_name: "cancel_icon")]
    }()
   
    
    @objc func ShowSettings() {
        
        //Bottom Slide-out menu
        
        if let window = UIApplication.shared.keyWindow{
            
            
            darkView.backgroundColor = .init(white: 0, alpha: 0.7)
            darkView.frame = window.frame
            darkView.alpha = 0
            
            darkView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            window.addSubview(darkView)
            window.addSubview(collectionView)
            
            let cv_position_height: CGFloat = 250
            
            let  cv_position_bottom = window.frame.height - cv_position_height
            
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: cv_position_bottom)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.darkView.alpha = 1
                
                self.collectionView.frame = CGRect(x: 0, y: cv_position_bottom, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
                
                
            }, completion: nil)
        
        }
            
    }
    
    @objc func handleDismiss(){
        
        UIView.animate(withDuration: 0.7, animations: {
            self.darkView.alpha = 0
            
            if let window = UIApplication.shared.keyWindow {
                
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
        })
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellid, for: indexPath) as! SettingsCell
        let setting = settings[indexPath.item]
        cell.setting = setting
      
        return cell
       }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
override init() {
    
    super.init()
    
    collectionView.dataSource = self
    collectionView.delegate = self
    
    collectionView.register(SettingsCell.self, forCellWithReuseIdentifier: cellid)
        
    }
}
