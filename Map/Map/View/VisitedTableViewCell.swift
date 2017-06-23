//
//  VisitedTableViewCell.swift
//  Map
//
//  Created by Marcin on 17.06.2017.
//  Copyright © 2017 Marcin Włoczko. All rights reserved.
//

import UIKit

class VisitedTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var coordinateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUpCell(pin: Pin) {
        nameLabel.text = pin.name
        coordinateLabel.text = "\(pin.lat) E, \(pin.lng) N"
    }
    
}
