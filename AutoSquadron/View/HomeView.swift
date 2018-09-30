//
//  HomeView.swift
//  AutoSquadron
//
//  Created by Vivek Rai on 16/09/18.
//  Copyright © 2018 Vivek Rai. All rights reserved.
//

import UIKit

@IBDesignable
class HomeView: UIView {
    
    @IBInspectable var topColor: UIColor = UIColor.gray{
        didSet{
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var bottomColor: UIColor = UIColor.darkGray{
        didSet{
            self.setNeedsLayout()
        }
    }
    
    override func layoutSubviews() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor, topColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
}

