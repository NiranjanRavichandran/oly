//
//  UI+Extensions.swift
//  oly
//
//  Created by Niranjan Ravichandran on 9/14/18.
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


extension UIView {
    
    /* Adds view as subview and increases the height of the current view. */
    func pushSubView(view: UIView) {
        view.frame.origin.y = self.frame.height
        self.frame.size.height += view.frame.height
        self.addSubview(view)
    }
    
    /**
     Adds a shadow to the view its called from
     
     - parameter radius:       Radius of the shadow.
     - parameter offsetWidth:  Width of the shadow.
     - parameter offsetHeight: Height of the shadow.
     - parameter color:        Color of the shadow.
     - parameter opacity:      Opacity of shadow [0,1] range will give undefined results.
     */
    
    func dropShadow(radius: CGFloat = 3, offsetWidth: CGFloat = 0, offsetHeight: CGFloat = 0, color: UIColor = UIColor.black.withAlphaComponent(0.65), opacity: Float = 0.8, path: Bool = true) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = CGSize(width: offsetWidth, height: offsetHeight)
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
        if path {
            self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: 6).cgPath
        }
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
}

extension UIViewController {
    /* Adds the viewController passed as child VC, adds view as subview and sets parent to current VC */
    func addChildVC(viewController: UIViewController) {
        addChild(viewController)
        view.addSubview(viewController.view)
        viewController.didMove(toParent: self)
    }
}
