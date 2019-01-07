//
//  MenuViewController.swift
//  SlideInMenu
//
//  Created by Alvin on 7/1/19.
//  Copyright © 2019 Alvin. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var label: UILabel!
}

class MenuViewController: UIViewController {
    
    var dataSource = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 6"]
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
    }

}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.label.text = dataSource[indexPath.row]
        
        return cell
    }
    
    
}
