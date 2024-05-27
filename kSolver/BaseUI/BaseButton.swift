//
//  BaseButton.swift
//  kSolver
//
//  Created by Nikita Stepanov on 26.05.2024.
//

import Foundation
import UIKit

class StandartButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        layer.cornerRadius = 10
        clipsToBounds = true
        tintColor = .white
        setBackgroundColor()
        setRadiusWithShadow()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setTitle(_ title: String?,
                           for state: UIControl.State) {
        self.setAttributedTitle(NSAttributedString(string: title ?? "",
                                                   attributes: [NSAttributedString.Key.font : K.font!,
                                                                NSAttributedString.Key.strokeColor : UIColor.white.cgColor,
                                                               ]),
                                  for: .normal)
        titleLabel?.textColor = .white
        titleLabel?.numberOfLines = 0
    }
    
    func setBackgroundColor() {
        backgroundColor = .systemRed
        
    }
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                if backgroundColor != .clear {
                    backgroundColor = .systemGray
                    setRadiusWithShadow(withColor: .darkGray)
                }
            }
            else {
                setBackgroundColor()
                setRadiusWithShadow()
            }
        }
    }
}

extension UIView {
    func setRadiusWithShadow(_ radius: CGFloat? = nil,
                             withColor color: UIColor? = .red) {
        self.layer.shadowColor = color?.cgColor
        self.layer.shadowOffset = CGSize(width: 0,
                                         height: 3.0)
        layer.borderWidth = 2
        layer.borderColor = color?.cgColor
        self.layer.shadowRadius = 1.0
        self.layer.shadowOpacity = 1.0
        self.layer.masksToBounds = false
    }
}
