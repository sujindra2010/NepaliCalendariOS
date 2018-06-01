//
//  UIExtension.swift
//  Nepali calendar
//
//  Created by Sujindra Maharjan on 6/1/18.
//  Copyright © 2018 Sujindra Maharjan. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(CFloat(red) / 255.0), green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
extension UIView{
    public func addShadowBorder(){
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.cornerRadius = 4
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.15
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.masksToBounds = false
    }
    public func addCornerRadius(radius:Int){
        self.layer.cornerRadius = CGFloat(radius)
        self.clipsToBounds = true
    }
    
    public func setCircularRadius(){
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
    }
    
    @discardableResult
    func addBorders(edges: UIRectEdge,
                    color: UIColor,
                    inset: CGFloat = 0.0,
                    thickness: CGFloat = 1.0) -> [UIView] {
        
        var borders = [UIView]()
        
        @discardableResult
        func addBorder(formats: String...) -> UIView {
            let border = UIView(frame: .zero)
            border.backgroundColor = color
            border.translatesAutoresizingMaskIntoConstraints = false
            addSubview(border)
            addConstraints(formats.flatMap {
                NSLayoutConstraint.constraints(withVisualFormat: $0,
                                               options: [],
                                               metrics: ["inset": inset, "thickness": thickness],
                                               views: ["border": border]) })
            borders.append(border)
            return border
        }
        
        
        if edges.contains(.top) || edges.contains(.all) {
            addBorder(formats: "V:|-0-[border(==thickness)]", "H:|-inset-[border]-inset-|")
        }
        
        if edges.contains(.bottom) || edges.contains(.all) {
            addBorder(formats: "V:[border(==thickness)]-0-|", "H:|-inset-[border]-inset-|")
        }
        
        if edges.contains(.left) || edges.contains(.all) {
            addBorder(formats: "V:|-inset-[border]-inset-|", "H:|-0-[border(==thickness)]")
        }
        
        if edges.contains(.right) || edges.contains(.all) {
            addBorder(formats: "V:|-inset-[border]-inset-|", "H:[border(==thickness)]-0-|")
        }
        
        return borders
    }
    
}

extension UIButton {
    func addCircleCornerRadius(){
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
        
    }
    func addBorder(color:UIColor){
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = 1
    }
}


class CardView:UIView {
    override func awakeFromNib() {
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
    }
}
class TextFieldView:UIView {
    override func awakeFromNib() {
        self.layer.cornerRadius = 6
        self.clipsToBounds = true
    }
}

class RoundedButton:UIButton {
    override func awakeFromNib() {
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
}
}


