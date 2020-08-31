//
//  UIView+Constraints.swift
//  mobile-au
//
//  Created by Vladislav on 2/4/19.
//  Copyright © 2019 HUDWAY. All rights reserved.
//

import UIKit

extension UIView {
    func addConstraintsMatchSuperview() {
        guard let superView = self.superview else {
            return
        }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        superView.addConstraint(between: self, firstConstraintAttribute: .leading, secondControl: superView, secondConstraintAttribute: .leading, value: 0)
        superView.addConstraint(between: self, firstConstraintAttribute: .trailing, secondControl: superView, secondConstraintAttribute: .trailing, value: 0)
        superView.addConstraint(between: self, firstConstraintAttribute: .top, secondControl: superView, secondConstraintAttribute: .top, value: 0)
        superView.addConstraint(between: self, firstConstraintAttribute: .bottom, secondControl: superView, secondConstraintAttribute: .bottom, value: 0)
    }
    
    func addConstraint(between firstControl:UIView, firstConstraintAttribute: NSLayoutConstraint.Attribute, secondControl: UIView, secondConstraintAttribute: NSLayoutConstraint.Attribute, value: Float) {
        self.addConstraint(NSLayoutConstraint.init(item: firstControl,
                                                   attribute: firstConstraintAttribute,
                                                   relatedBy: .equal,
                                                   toItem: secondControl,
                                                   attribute: secondConstraintAttribute,
                                                   multiplier: 1.0, constant: CGFloat(value)))
    }
    
    func addConstraint(to subview: UIView, attribute: NSLayoutConstraint.Attribute, value: CGFloat) {
        self.addConstraint(NSLayoutConstraint.init(item: subview,
                                                   attribute: attribute,
                                                   relatedBy: .equal,
                                                   toItem: self,
                                                   attribute: attribute,
                                                   multiplier: 1.0,
                                                   constant: value))
    }
}
