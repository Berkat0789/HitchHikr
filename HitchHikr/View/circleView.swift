//
//  circleView.swift
//  HitchHikr
//
//  Created by berkat bhatti on 2/5/18.
//  Copyright © 2018 TKM. All rights reserved.
//

import UIKit
@IBDesignable
class circleView: UIView {
//--because we are using this for both colors circle, instead of making two different subclases we use an ib inspectable (varibale that interface builder allwos you to modify)
    @IBInspectable var borderColor: UIColor? {
        didSet {
            updateView()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        updateView()
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        updateView()
    }
    func updateView() {
        self.layer.cornerRadius = self.frame.width / 2
        self.layer.borderWidth = 1.5
        self.layer.borderColor = borderColor?.cgColor
        
    }

}
