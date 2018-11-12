//
//  UIItems.swift
//  oly
//
//  Created by Niranjan Ravichandran on 11/9/18.
//  Copyright © 2018 Aviato. All rights reserved.
//

import UIKit

class OUIBouncyControl: UIControl {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addTarget(self, action: #selector(self.onTouchDown(sender:)), for: .touchDown)
        self.addTarget(self, action: #selector(self.onTouchCancel(sender:)), for: [.touchDragExit, .touchDragOutside, .touchUpInside, .touchUpOutside, .touchCancel])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func onTouchDown(sender: UIControl) {
        UIView.animate(withDuration: 0.3, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { (_) in
            //NADA
        }
        
    }
    
    @objc private func onTouchCancel(sender: UIControl) {
        UIView.animate(withDuration: 0.2) {
            sender.transform = CGAffineTransform.identity
        }
    }
}

