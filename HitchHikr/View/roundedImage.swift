//
//  roundedImage.swift
//  HitchHikr
//
//  Created by berkat bhatti on 2/5/18.
//  Copyright © 2018 TKM. All rights reserved.
//

import UIKit
@IBDesignable
class roundedImage: UIImageView {

    override func awakeFromNib() {
      super.awakeFromNib()
        UpdateView()
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        UpdateView()
    }
    func UpdateView() {
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
    }

}
