//
//  TabViewController.swift
//  oly
//
//  Created by Niranjan Ravichandran on 6/1/18.
//  Copyright © 2018 Aviato. All rights reserved.
//

import UIKit

class TabViewController: UITabBarController {
    
    private var recordingsVC: UINavigationController!
    private var transcribeVC: UINavigationController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        recordingsVC = UINavigationController(rootViewController: RecordingsViewController())
        recordingsVC.tabBarItem = UITabBarItem.init(title: "", image: #imageLiteral(resourceName: "icon-audioWaveFilled"), selectedImage: nil)
        recordingsVC.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0)
        self.viewControllers = [recordingsVC]
        transcribeVC = UINavigationController(rootViewController: TranscribeViewController())
        transcribeVC.tabBarItem = UITabBarItem.init(title: "", image: #imageLiteral(resourceName: "icon-list"), selectedImage: nil)
        transcribeVC.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0)
        self.viewControllers?.append(transcribeVC)
        
        UITabBar.appearance().layer.borderWidth = 0
        UITabBar.appearance().clipsToBounds = true
        UITabBar.appearance().tintColor = UIColor.oRedColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
