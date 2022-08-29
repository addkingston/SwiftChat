//
//  CustomTabBar.swift
//  SwiftChat
//
//  Created by Admin on 10.08.2022.
//
import UIKit


class CustomTabBar: UITabBar {
    
    private var shapeLayer: CALayer?
    
    override func draw(_ rect: CGRect) {
        self.addShape()
//        layer.backgroundColor = UIColor.darkGray.cgColor
//        layer.borderWidth = 1
//        layer.borderColor = UIColor.gray.cgColor
    }
    
    private func addGradient() {
        let layerGradient = CAGradientLayer()
        layerGradient.colors = [UIColor.red.cgColor, UIColor.yellow.cgColor]
        layerGradient.startPoint = CGPoint(x: 0, y: 0.5)
        layerGradient.endPoint = CGPoint(x: 1, y: 0.5)
        layerGradient.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        layerGradient.mask = shapeLayer
    }

    private func addShape() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        shapeLayer.path = createPath()
        self.layer.insertSublayer(shapeLayer, at: 0)
        self.shapeLayer = shapeLayer

        let gradientLayer = CAGradientLayer()
        gradientLayer.mask = self.shapeLayer
        gradientLayer.frame = self.shapeLayer!.frame
        gradientLayer.contentsScale = UIScreen.main.scale
        gradientLayer.colors = [UIColor(hexString: "#29282C").cgColor, UIColor(hexString: "#09090A").cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func createPath() -> CGPath {
        let height: CGFloat = 20.0
        let path = UIBezierPath()
        let centerWidth = self.frame.width / 2
        
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: (centerWidth - height * 3.5), y: 0))
        
        path.addCurve(to: CGPoint(x: centerWidth, y: height),
                      controlPoint1: CGPoint(x: (centerWidth - 30), y: 0), controlPoint2: CGPoint(x: centerWidth - 35, y: height))
        path.addCurve(to: CGPoint(x: (centerWidth + height * 3.5), y: 0),
                      controlPoint1: CGPoint(x: centerWidth + 35, y: height), controlPoint2: CGPoint(x: (centerWidth + 30), y: 0))
        
        path.addLine(to: CGPoint(x: self.frame.width, y: 0))
        path.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
        path.addLine(to: CGPoint(x: 0, y: self.frame.height))
        path.close()
        
        return path.cgPath
    }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard !clipsToBounds && !isHidden && alpha > 0 else { return nil }
        for member in subviews.reversed() {
            let subPoint = member.convert(point, from: self)
            guard let result = member.hitTest(subPoint, with: event) else { continue }
            return result
        }
        return nil
    }
}

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

