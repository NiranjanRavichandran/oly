//
//  OUITransparentViewController.swift
//  oly
//
//  Created by Niranjan Ravichandran on 6/1/18.
//  Copyright © 2018 Aviato. All rights reserved.
//

import UIKit

class OUITransparentViewController: OUIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.isTranslucent = true
        
        self.transitionCoordinator?.animate(alongsideTransition: { (context) in
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        }, completion: { (context) in
            
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
    }
    
    override func viewWillDisappear(_ animated: Bool) {

    }


}
