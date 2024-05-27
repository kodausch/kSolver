//
//  BaseLabel.swift
//  kSolver
//
//  Created by Nikita Stepanov on 26.05.2024.
//

import Foundation
import UIKit

class BaseLabel: UILabel {
    func setUp() {
        textColor = .white
        font = K.font
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
