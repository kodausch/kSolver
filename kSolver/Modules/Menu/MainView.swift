//
//  MainView.swift
//  kSolver
//
//  Created by Nikita Stepanov on 26.05.2024.
//

import Foundation
import UIKit

class MenuView: BaseView {
    
    let pattern1Button = StandartButton()
    let pattern1InfoButton = StandartButton()
    let manImage: UIImageView = .init(image: UIImage(named: "man"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension MenuView {
    func setup() {
        addSubview(pattern1Button)
        
        pattern1Button.setTitle("""
Паттерн
максимизации
""", for: .normal)
        manImage.contentMode = .scaleAspectFit
        addSubview(pattern1InfoButton)
        
        pattern1InfoButton.setTitle("""
Пример задачи
""", for: .normal)
        
        pattern1InfoButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.horizontalEdges.equalTo(pattern1Button)
            make.centerX.equalTo(pattern1Button)
            make.bottom.equalTo(pattern1Button.snp.top).offset(-20)
        }
        
        pattern1Button.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(50)
            make.centerY.equalToSuperview()
        }
        
        frameView.snp.updateConstraints { make in
            make.verticalEdges.equalToSuperview().inset(150)
        }
    }
}
