//
//  File.swift
//  SwiftChat
//
//  Created by MacBook on 08.06.2022.
//

import UIKit
import SwiftPhoneNumberFormatter

extension UIColor {
    
    // MARK: UIColor + Colors
    
    static let pink = UIColor(red: 209/255, green: 58/255, blue: 156/255, alpha: 50)
    static let darkPink = UIColor(red: 183/255, green: 101/255, blue: 177/255, alpha: 50)
    static let salat = UIColor(red: 109/255, green: 234/255, blue: 125/255, alpha: 0.75)
    static let sand = UIColor(red: 223/225, green: 171/225, blue: 80/225, alpha: 50)
    static let cloud = UIColor(red: 245/255, green: 244/255, blue: 235/255, alpha: 50)
}

extension UIImage {
    
    // MARK: UIImage + Images
    
    static let image1 = UIImage(named: "ghost")
    
}

extension UIButton {
    
    
    
    private func imageWithColor(color: UIColor) -> UIImage? {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        self.setBackgroundImage(imageWithColor(color: color), for: state)
    }
}
 class PaddedPhoneTextField: PhoneFormattedTextField {

    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
class PaddedSMSTextField: PhoneFormattedTextField {

    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}

extension String {

    var length: Int {
        return count
    }

    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }

    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }

    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }

    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
}

extension String {
    
    func textFrame(font: UIFont)-> CGSize {
        let widthConstraint = UIScreen.main.bounds.width - 60
        
        let height = height(withConstrainedWidth: widthConstraint, font: font)
        let width = width(withConstrainedHeight: height, font: font)
        
        return CGSize(width: width, height: height)
    }
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
    
        return ceil(boundingBox.height)
    }

    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: UIScreen.main.bounds.width - 60, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return ceil(boundingBox.width)
    }
}
