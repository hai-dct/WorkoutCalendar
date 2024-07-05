//
//  UIViewExt.swift
//  PJMusic
//
//  Created by HaiNguyenHP on 05/07/2024.
//

import UIKit.UIView

extension UIView {
    
    func addTapGesture(tapNumber: Int = 1, target: Any, action: Selector) {
        let tap = UITapGestureRecognizer(target: target, action: action)
        tap.numberOfTapsRequired = tapNumber
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
    }
    
    func addNotificationObserver(name: Notification.Name, selector: Selector) {
        NotificationCenter.default.addObserver(self, selector: selector, name: name, object: nil)
    }
    
    struct AnchorOptions: OptionSet {
        
        let rawValue: Int
        
        init(rawValue: Int) {
            self.rawValue = rawValue
        }
        
        static let top = UIView.AnchorOptions(rawValue: 1 << 0)
        
        static let leading = UIView.AnchorOptions(rawValue: 1 << 1)
        
        static let trailing = UIView.AnchorOptions(rawValue: 1 << 2)
        
        static let bottom = UIView.AnchorOptions(rawValue: 1 << 3)
        
        static let all: UIView.AnchorOptions = [.top, .leading, .trailing, .bottom]
    }
    
    func anchor(toView view: UIView?, insets: UIEdgeInsets = .zero, anchorOptions options: AnchorOptions = .all) {
        guard let view = view else { return }
        translatesAutoresizingMaskIntoConstraints = false
        
        if options.contains(.top) {
            topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top).isActive = true
        }
        if options.contains(.leading) {
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: insets.left).isActive = true
        }
        if options.contains(.trailing) {
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: insets.right).isActive = true
        }
        if options.contains(.bottom) {
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: insets.bottom).isActive = true
        }
    }
    
    func anchorToSuperView(with insets: UIEdgeInsets = .zero) {
        guard let superview = superview else { return }
        anchor(toView: superview, insets: insets)
    }
    
    func heightAnchor(_ constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: constant).isActive = true
    }
    
    func widthAnchor(_ constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: constant).isActive = true
    }
}

extension UIView {
    
    enum BorderPostition {
        case top
        case left
        case bottom
        case right
    }

    func border(_ pos: BorderPostition, color: UIColor = UIColor.black, width: CGFloat = 0.5, insets: UIEdgeInsets = UIEdgeInsets.zero) {
           let oldView = subviews.first { $0.tag == 99 }
           oldView?.removeFromSuperview()
           let rect: CGRect = {
               switch pos {
               case .top: return CGRect(x: 0, y: 0, width: frame.width, height: width)
               case .left: return CGRect(x: 0, y: 0, width: width, height: frame.height)
               case .bottom:
                   let origin = CGPoint(x: insets.left, y: frame.height - width)
                   let size = CGSize(width: frame.width - (insets.left + insets.right), height: width)
                   return CGRect(origin: origin, size: size)
               case .right: return CGRect(x: frame.width - width, y: 0, width: width, height: frame.height)
               }
           }()
           let border = UIView(frame: rect)
           border.tag = 99 // Mask for remove
           border.backgroundColor = color
           border.autoresizingMask = {
               switch pos {
               case .top: return [.flexibleWidth, .flexibleBottomMargin]
               case .left: return [.flexibleHeight, .flexibleRightMargin]
               case .bottom: return [.flexibleWidth, .flexibleTopMargin]
               case .right: return [.flexibleHeight, .flexibleLeftMargin]
               }
           }()
           addSubview(border)
       }
}
