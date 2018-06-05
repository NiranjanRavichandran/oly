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
    private var centerButton: OUICenterButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        recordingsVC = UINavigationController(rootViewController: RecordingsViewController())
        recordingsVC.tabBarItem = UITabBarItem.init(title: "", image: #imageLiteral(resourceName: "icon-audioWaveFilled"), selectedImage: nil)
        recordingsVC.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0)
        self.viewControllers = [recordingsVC]
        
        let recordVC = UINavigationController(rootViewController: RecordViewController())
        recordVC.tabBarItem = UITabBarItem.init(title: "", image: nil, selectedImage: nil)
//        recordVC.tabBarItem.imageInsets = UIEdgeInsetsMake(-10, 0, 6, 0)
        self.viewControllers?.append(recordVC)
        
        transcribeVC = UINavigationController(rootViewController: TranscribeViewController())
        transcribeVC.tabBarItem = UITabBarItem.init(title: "", image: #imageLiteral(resourceName: "icon-list"), selectedImage: nil)
        transcribeVC.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0)
        self.viewControllers?.append(transcribeVC)
        
        UITabBar.appearance().layer.borderWidth = 0
        UITabBar.appearance().tintColor = UIColor.oRedColor
        UITabBar.appearance().backgroundColor = UIColor.oLightGray 
        self.tabBar.shadowImage = UIImage()
        self.tabBar.backgroundImage = UIImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureCenterButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Mark: - Supporting fucntions
    
    private func configureCenterButton() {
        centerButton = OUICenterButton(frame: CGRect.init(x: 0, y: 0, width: 60, height: 60))
        centerButton.center.y = self.tabBar.bounds.midY - 15
        centerButton.center.x = self.tabBar.bounds.midX
        centerButton.addTarget(self, action: #selector(self.openRecordView), for: .touchUpInside)
        self.tabBar.addSubview(centerButton)
        self.tabBar.bringSubview(toFront: centerButton)
    }
    
    @objc private func openRecordView() {
        self.animateMic()
        self.switchTab(to: 1)
    }
    
    private func animateMic() {
        self.centerButton.animate()
    }
    
    private func switchTab(to index: Int) {
        self.selectedIndex = index
    }
    
    //MARK: - TabBarDelegate
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        //Note: self.selectedIndex is the index of currently selected tabBarItem
        if let index = tabBar.items?.index(of: item) {
            if index != selectedIndex {
                if index == 1 {
                    self.animateMic()
                }else {
                    self.centerButton.resetImage()
                }
            }
        }
    }

}

class OUICenterButton: UIControl {
    
    var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.oLightGray
        imageView = UIImageView(frame: CGRect.init(x: 15, y: 15, width: self.frame.width - 30, height: self.frame.height - 30))
        imageView.image = #imageLiteral(resourceName: "icon-microphone").withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor.darkGray
        imageView.contentMode = .scaleAspectFill
        self.addSubview(imageView)
        self.tintColor = UIColor.oRedColor
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animate() {
        UIView.animate(withDuration: 0.3) { () -> Void in
            self.imageView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        }
        
        UIView.animate(withDuration: 0.3, delay: 0.1, options: UIViewAnimationOptions.curveEaseIn, animations: { () -> Void in
            self.imageView.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 2.0)
            self.imageView.tintColor = UIColor.oRedColor
        }, completion: nil)
    }
    
    func resetImage() {
        self.imageView.tintColor = UIColor.darkGray
    }
}
