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
        initView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func initView() {
        nameLabel.text = currentPin.name
        lngLabel.text = String(currentPin.lng)
        latLabel.text = String(currentPin.lat)
        setImage()
    }
    
    private func setImage() {
        let url = URL(string: currentPin.imagePath)!
        ImageDownloader.getImage(url) { [weak self] (image, succes) in
            guard let actualImage = image else { return }
            self?.image.image = actualImage
        }
    }
}
