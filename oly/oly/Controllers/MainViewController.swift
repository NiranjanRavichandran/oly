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
        self.navigationItem.largeTitleDisplayMode = .always

        let recordingsVC = RecordingsViewController()
        self.addChildVC(viewController: recordingsVC)
        self.title = "Recordings"
        
        self.setupFloatingRecordButton()
    }
    
    func setupFloatingRecordButton() {
        let buttonSize: CGFloat = 65
        let recordButton = RecordButton(frame: CGRect.init(x: self.view.frame.width - (buttonSize + 15), y: self.view.frame.height - self.navbarHeight - (buttonSize + 20 + self.view.safeAreaInsets.bottom), width: buttonSize, height: buttonSize))
        recordButton.layer.zPosition = 1000
        recordButton.dropShadow(path: false)
        recordButton.addTarget(self, action: #selector(self.openRecordVC), for: .touchUpInside)
        self.view.addSubview(recordButton)
    }
    
    //MARK: - Navigation Helpers
    
    @objc func openRecordVC() {
        self.present(RecordViewController(), animated: true, completion: nil)
    }

}
