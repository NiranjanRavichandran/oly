//
//  RecordButton.swift
//  oly
//
//  Created by Niranjan Ravichandran on 9/14/18.
//  Copyright © 2018 Aviato. All rights reserved.
//

import UIKit

class RecordButton: UIControl {
    
    var icon: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
        self.backgroundColor = UIColor.oRedColor
        
        let size = self.frame.width * 0.65
        icon = UIImageView(frame: CGRect.init(x: 0, y: 0, width: size, height: size))
        icon.tintColor = .white
        icon.center = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        icon.image = UIImage(named: "icon-microphone")?.withRenderingMode(.alwaysTemplate)
        self.addSubview(icon)
        
        self.addTarget(self, action: #selector(self.onTouchDown(sender:)), for: .touchDown)
        self.addTarget(self, action: #selector(self.onTouchCancel(sender:)), for: [.touchDragExit, .touchDragOutside, .touchUpInside, .touchUpOutside, .touchCancel])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func onTouchDown(sender: UIControl) {
        let impact = UIImpactFeedbackGenerator(style: .light)
        UIView.animate(withDuration: 0.3, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.92, y: 0.92)
        }) { (_) in
            impact.impactOccurred()
        }
        
    }
    
    @objc private func onTouchCancel(sender: UIControl) {
        UIView.animate(withDuration: 0.2) {
            sender.transform = CGAffineTransform.identity
        }
    }
    
    
}
