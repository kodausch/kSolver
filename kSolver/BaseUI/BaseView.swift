//
//  BaseView.swift
//  kSolver
//
//  Created by Nikita Stepanov on 23.05.2024.
//

import Foundation
import UIKit
import SnapKit

class BaseView: UIView {
    
    private let backgroundImage: UIImageView = {
        let obj = UIImageView()
        obj.contentMode = .scaleAspectFill
        obj.image = UIImage(named: K.bgName)
        return obj
    }()
    
    // public чтобы если что настривать UI от нее
    public let frameView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = K.bigCornerRadius + 20
        view.clipsToBounds = true
        view.backgroundColor = .black.withAlphaComponent(0.95)
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor.white.cgColor
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    convenience init(backgroundImage: String) {
        self.init()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        
        addSubview(backgroundImage)
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        addSubview(frameView)
        frameView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(60)
        }
    }
}
