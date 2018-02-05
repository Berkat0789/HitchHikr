//
//  gradientView.swift
//  HitchHikr
//
//  Created by berkat bhatti on 2/5/18.
//  Copyright © 2018 TKM. All rights reserved.
//

import UIKit
@IBDesignable
class gradientView: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        updateView()
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        updateView()
    }

    let gradient = CAGradientLayer()
    
    
    func updateView() {
        gradient.frame = self.bounds
        gradient.colors = [UIColor.white.cgColor, UIColor.init(white: 1.0, alpha: 0.0).cgColor]
        gradient.startPoint = CGPoint.zero
        gradient.endPoint = CGPoint(x: 0, y: 1)
        gradient.locations = [0.8, 1.0]
        self.layer.addSublayer(gradient)
    }

}
