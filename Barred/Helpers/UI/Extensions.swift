//
//  Extensions.swift
//  Barred
//
//  Created by RCD on 24/05/2023.
//

import Foundation
import UIKit

//MARK: UIImage

extension UIImage {
    func imageResized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}

//MARK: UIView

extension UIView {
    
    
    public var width: CGFloat {
        return self.frame.size.width
    }
    
    public var height: CGFloat{
        return frame.size.height
    }
    
    public var top: CGFloat{
        return frame.origin.y
    }
    
    public var bottom: CGFloat{
        return frame.size.height + frame.origin.y
    }
    
    public var left: CGFloat{
        return frame.origin.x
    }
    
    public var right: CGFloat{
        return frame.size.width + frame.origin.x
    }
    
    func tamic() {
        self.translatesAutoresizingMaskIntoConstraints = true
    }
    
    func Activate(_ Constraints: [NSLayoutConstraint]){
        NSLayoutConstraint.activate(Constraints)
    }
    
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, trailing: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -(padding.right)).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -(padding.bottom)).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    func centerToX() {
        
        guard let superview = self.superview else {
            
            print ("DEBUG: Could not find superview")
            return
        }
        
        self.centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true
    }
    
    func centerToY() {
        
        guard let superview = self.superview else {
            
            print ("DEBUG: Could not find superview")
            return
        }
        
        self.centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive = true
    }
    
    func setWidth(_ width: CGFloat) {
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    func setHeight(_ height: CGFloat) {
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    func widthGreaterThanOrEqualToConstant(_ width: CGFloat) {
        self.widthAnchor.constraint(greaterThanOrEqualToConstant: width).isActive = true
    }
    
    func heightGreaterThanOrEqualToConstant(_ height: CGFloat) {
        self.heightAnchor.constraint(greaterThanOrEqualToConstant: height).isActive = true
    }
    
    func widthLessThanOrEqualTo(_ width: CGFloat) {
        self.widthAnchor.constraint(lessThanOrEqualToConstant: width).isActive = true
    }
    
    func heightLessThanOrEqualTo(_ height: CGFloat) {
        self.heightAnchor.constraint(lessThanOrEqualToConstant: height).isActive = true
    }
    
    func drawLine(on view: UIView, lineThickness: CGFloat = 1, lineColor: UIColor = UIColor.black, lineWidth: CGFloat ) {
        
        let bp = UIBezierPath()
        bp.move(to: CGPoint(x: 0, y: 0))
        bp.addLine(to: CGPoint(x: lineWidth, y: 0))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = lineColor.cgColor
        shapeLayer.backgroundColor = lineColor.cgColor
        shapeLayer.path = bp.cgPath
        shapeLayer.lineWidth = lineThickness
        shapeLayer.contentsGravity = .center
        
        view.layer.addSublayer(shapeLayer)
    }
    
    func addInnerShadow() {
        
        let innerShadow = CALayer()
        innerShadow.frame = bounds
        
        // Shadow path (1pt ring around bounds)
        let radius = self.layer.cornerRadius
        let path = UIBezierPath(roundedRect: innerShadow.bounds.insetBy(dx: 0, dy:2), cornerRadius:radius)
        let cutout = UIBezierPath(roundedRect: .init(x: 0, y: 0, width: width, height: height - 2), cornerRadius:radius).reversing()
        
        path.append(cutout)
        innerShadow.shadowPath = path.cgPath
        innerShadow.masksToBounds = true
        
        // Shadow properties
        innerShadow.shadowColor = UIColor.black.cgColor
        innerShadow.shadowOffset = CGSize(width: 0, height: 0)
        innerShadow.shadowOpacity = 0.3
        innerShadow.shadowRadius = 5
        innerShadow.cornerRadius = self.layer.cornerRadius
        layer.addSublayer(innerShadow)
    }
    
    func setShadow(on view: UIView, color: UIColor = .black, shadowRadius:CGFloat = 5, shadowOpacity: Float = 5, shadowOffset: CGSize = .zero) {
        
        self.layer.shadowColor = color.cgColor
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowOffset = .zero
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }

}

//MARK: Text Field
extension UITextField {
    
    
    func setPlaceholder(text: String, color: UIColor, underline: NSUnderlineStyle? = nil, font: UIFont? = nil) {
        
        if let underline = underline {
            
            self.attributedPlaceholder = NSAttributedString( string: text.localized(),
                                                             attributes: [.foregroundColor:color,
                                                                          .underlineStyle: underline.rawValue,
                                                             ])
        } else if  let font = font {
            
            self.attributedPlaceholder = NSAttributedString( string: text.localized(),
                                                             attributes: [.foregroundColor:color,
                                                                          .font: font
                                                             ])
        } else if let font = font, let underline = underline {
            
            self.attributedPlaceholder = NSAttributedString( string: text.localized(),
                                                             attributes: [.foregroundColor:color,
                                                                          .font: font,
                                                                          .underlineStyle: underline,
                                                             ])
        }  else {
            
            self.attributedPlaceholder = NSAttributedString( string: text.localized(),
                                                             attributes: [NSAttributedString.Key.foregroundColor:color])
        }
        
    }
    
    func setUnderLine(_ color: UIColor) {
        
        let border = CALayer()
        border.borderColor = color.cgColor
        let underlineWidth = self.width/1.05
        border.frame = CGRect(x: self.width - (self.width/2) - (underlineWidth/2), y: self.height - 1, width: underlineWidth, height: 1)
        border.borderWidth = 1
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
}

