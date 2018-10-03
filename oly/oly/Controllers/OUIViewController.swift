//
//  OUIViewController.swift
//  oly
//
//  Created by Niranjan Ravichandran on 6/1/18.
//  Copyright © 2018 Aviato. All rights reserved.
//

import UIKit

class OUIViewController: UIViewController {
    
    lazy var navbarHeight: CGFloat = {
        self.navigationController?.navigationBar.frame.maxY ?? 0
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isTranslucent = false
        
        self.transitionCoordinator?.animate(alongsideTransition: { (context) in
            self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
        }, completion: { (context) in
            
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

}
