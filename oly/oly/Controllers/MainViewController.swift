//
//  MainViewController.swift
//  oly
//
//  Created by Niranjan Ravichandran on 9/14/18.
//  Copyright © 2018 Aviato. All rights reserved.
//

import UIKit

class MainViewController: OUIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let recordingsVC = RecordingsViewController()
        self.view.addSubview(recordingsVC.view)
        recordingsVC.didMove(toParent: self)
        
        self.navigationItem.largeTitleDisplayMode = .always
        self.title = "Recordings"
    }

}
