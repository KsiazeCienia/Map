//
//  SinglePlaceViewController.swift
//  Map
//
//  Created by Marcin on 17.06.2017.
//  Copyright © 2017 Marcin Włoczko. All rights reserved.
//

import UIKit

final class SinglePlaceViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lngLabel: UILabel!
    @IBOutlet weak var latLabel: UILabel!
    
    var currentPin: Pin!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(currentPin.id)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func initView() {
        nameLabel.text = currentPin.name
        lngLabel.text = String(currentPin.lng)
        latLabel.text = String(currentPin.lat)
    }
    
    private func setImage() {
        
    }
}
