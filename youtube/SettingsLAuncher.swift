//
//  SettingsLAuncher.swift
//  YouTube_Clone
//
//  Created by mac on 9/30/19.
//  Copyright © 2019 letsbuildthatapp. All rights reserved.
//

import UIKit

class SettingsLauncher: NSObject, UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
     let cell = "cellId"
    
    
    let darkView = UIView()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        
        return cv
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
            
            let cv_position_height : CGFloat = 200
            
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
           return 3
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath)
           
           return cell
       }
    


override init() {
    
    super.init()
    
    collectionView.dataSource = self
    collectionView.delegate = self
    
    collectionView.register(SettingsCell.self, forCellWithReuseIdentifier: cell)
        
    }
}
