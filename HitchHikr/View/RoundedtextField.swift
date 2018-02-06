//
//  RoundedtextField.swift
//  HitchHikr
//
//  Created by berkat bhatti on 2/6/18.
//  Copyright © 2018 TKM. All rights reserved.
//

import UIKit
@IBDesignable
class RoundedtextField: UITextField {
    let textpadding = UIEdgeInsetsMake(0, 20, 0, 0)
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, textpadding)
    }
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, textpadding)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, textpadding)
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
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
        
        let placeholder = NSAttributedString(string: self.placeholder!, attributes: [NSAttributedStringKey.foregroundColor: #colorLiteral(red: 1, green: 0.5882352941, blue: 0.03137254902, alpha: 1)])
        self.attributedPlaceholder = placeholder
        
    }

}
