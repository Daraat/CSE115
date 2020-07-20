//
//  profileCustom.swift
//  CSE115
//
//  Created by Dara Abedini tafreshi on 7/17/20.
//  Copyright © 2020 Dara Abedini tafreshi. All rights reserved.
//

import UIKit


extension UIImageView {

    func makeRound() {

        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = self.frame.size.width  / 2
        self.clipsToBounds = true
    }
}
