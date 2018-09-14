//
//  RecordingsViewController.swift
//  oly
//
//  Created by Niranjan Ravichandran on 6/1/18.
//  Copyright © 2018 Aviato. All rights reserved.
//

import UIKit

class RecordingsViewController: OUITransparentViewController {
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        tableView = UITableView(frame: self.view.bounds)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RecordTableCell.self, forCellReuseIdentifier: String(describing: RecordTableCell.self))
        self.view.addSubview(tableView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}


extension RecordingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RecordTableCell.self), for: indexPath) as! RecordTableCell
        
        return cell
    }
}
