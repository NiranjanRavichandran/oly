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
        self.view.backgroundColor = .white

//        let recordingsVC = RecordingsViewController()
//        self.view.addSubview(recordingsVC.view)
//        recordingsVC.didMove(toParent: self)
        
        self.navigationItem.largeTitleDisplayMode = .always
        self.title = "Recordings"
        
        self.setupFloatingRecordButton()
    }
    
    func setupFloatingRecordButton() {
        let buttonSize: CGFloat = 65
        let recordButton = RecordButton(frame: CGRect.init(x: self.view.frame.width - (buttonSize + 15), y: self.view.frame.height - self.navbarHeight - (buttonSize + 25), width: buttonSize, height: buttonSize))
        self.view.addSubview(recordButton)
    }

}
