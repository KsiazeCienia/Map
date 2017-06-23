//
//  UITableViewCell+Identifier.swift
//  Map
//
//  Created by Marcin on 17.06.2017.
//  Copyright © 2017 Marcin Włoczko. All rights reserved.
//

import UIKit

extension UITableViewCell {
    public static var identifier: String {
        return String(describing: self)
    }
}

