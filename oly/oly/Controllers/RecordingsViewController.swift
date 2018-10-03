//
//  RecordingsViewController.swift
//  oly
//
//  Created by Niranjan Ravichandran on 6/1/18.
//  Copyright © 2018 Aviato. All rights reserved.
//

import UIKit
import CoreData

class RecordingsViewController: OUIViewController {
   
    var tableView: UITableView!
    var searchBar: UISearchBar?
    var records: [Record]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        tableView = UITableView(frame: self.view.bounds)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RecordTableCell.self, forCellReuseIdentifier: String(describing: RecordTableCell.self))
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.searchBarStyle = .minimal
        searchController.hidesNavigationBarDuringPresentation = false
        self.searchBar = searchController.searchBar
        tableView.tableHeaderView = searchController.searchBar
        tableView.tableHeaderView?.backgroundColor = .white
        tableView.keyboardDismissMode = .onDrag
        navigationItem.hidesSearchBarWhenScrolling = true
        
        self.view.addSubview(tableView)
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @objc func loadData() {
        self.records = nil
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Recordings")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                let recordData = Record.init(managedObject: data)
                if self.records == nil {
                    self.records = [recordData]
                } else {
                    self.records?.append(recordData)
                }
            }
            
            tableView.reloadData()
            tableView.refreshControl?.endRefreshing()
            
        } catch {
            
            print(">>>>>Failed<<<<<")
        }
    }

}

//MARK: - UITableViewDelegate
extension RecordingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.records?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RecordTableCell.self), for: indexPath) as! RecordTableCell
        if let record = self.records?[indexPath.row] {
            let recordModel = RecordTableCellModel(record: record)
            cell.prepareView(withRecord: recordModel)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

//MARK: - UISearchControllerDelegate
extension RecordingsViewController: UISearchControllerDelegate {
    
    
}


//MARK: - UIScrollViewDelegate
extension RecordingsViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //NADA
    }
}
