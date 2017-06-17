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
        setUpTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func setUpTableView() {
        visitedTableView.delegate = self
        visitedTableView.dataSource = self
        visitedTableView.register(UINib(nibName: VisitedTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: VisitedTableViewCell.identifier)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = sender as? IndexPath else { return }
        let singlePlaceVC = segue.destination as! SinglePlaceViewController
        singlePlaceVC.currentPin = pins[indexPath.row]
    }
}

extension LastVisitedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let visitedCell = visitedTableView.dequeueReusableCell(withIdentifier: VisitedTableViewCell.identifier) as! VisitedTableViewCell
        visitedCell.setUpCell(pin: pins[indexPath.row])
        return visitedCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Segue.goToSinglePlaceFromVisited, sender: indexPath)
    }
}
