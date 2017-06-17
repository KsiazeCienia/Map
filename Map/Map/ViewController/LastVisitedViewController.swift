//
//  LastVisitedViewController.swift
//  Map
//
//  Created by Marcin on 17.06.2017.
//  Copyright © 2017 Marcin Włoczko. All rights reserved.
//

import UIKit

class LastVisitedViewController: UIViewController {
    
    @IBOutlet weak var visitedTableView: UITableView!
    
    let dataBase = DataBase()
    
    var pins = [Pin]()

    override func viewDidLoad() {
        super.viewDidLoad()
        pins = dataBase.getData()
        setUpDelegates()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func setUpDelegates() {
        visitedTableView.delegate = self
        visitedTableView.dataSource = self
    }
}

extension LastVisitedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
}
