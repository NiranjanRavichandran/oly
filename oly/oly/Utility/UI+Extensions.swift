//
//  UI+Extensions.swift
//  oly
//
//  Created by Niranjan Ravichandran on 9/14/18.
//  Copyright © 2018 Aviato. All rights reserved.
//

import UIKit

//MARK: - UIView

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

//MARK: - UIViewController

extension UIViewController {
    /* Adds the viewController passed as child VC, adds view as subview and sets parent to current VC */
    func addChildVC(viewController: UIViewController) {
        addChild(viewController)
        view.addSubview(viewController.view)
        viewController.didMove(toParent: self)
    }
}


//MARK: - UIFont

extension UIFont {
    
    /**
     Returns a scaled font size for the given font-name and stle
     
     - parameter name:       Font name in String.
     - parameter textStyle:  UIFont.TextStyle.
     */
    class func scaledFont(name: String, textStyle: UIFont.TextStyle = .body) -> UIFont {
        
        let userFont =  UIFontDescriptor.preferredFontDescriptor(withTextStyle: textStyle)
        let pointSize = userFont.pointSize
        guard let customFont = UIFont(name: name, size: pointSize) else {
            fatalError("""
                Failed to load the "\(name)" font.
                Make sure the font file is included in the project and the font name is spelled correctly.
                """
            )
        }
        return UIFontMetrics.default.scaledFont(for: customFont)
    }
    
    /* Returns scaled font for given style with current font */
    func getScaledFont(with style: UIFont.TextStyle = .body) -> UIFont {
        return UIFont.scaledFont(name: self.fontName, textStyle: style)
    }
}
