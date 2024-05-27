//
//  ShowPopUp.swift
//  kSolver
//
//  Created by Nikita Stepanov on 26.05.2024.
//

import Foundation
import UIKit
import FFPopup

extension UIViewController {
  
  func showPopUp() {
    
    let view: UIView = .init(frame: .zero)
      view.frame = CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.height - 200))
    view.layer.cornerRadius = 30
    view.layer.borderColor = UIColor.white.cgColor
    view.layer.borderWidth = 4
      view.backgroundColor = UIColor.black
    
    let label: BaseLabel = .init(frame: .zero)
      label.font = UIFont(name: K.fontName,
                          size: 15)
          label.text = """
Компания производит полки для ванных комнат двух размеров - А и В. Агенты по продаже считают, что в неделю на рынке может быть реализовано до 550 полок. Для каждой полки типа А требуется 2 м2 материала, а для полки типа В - 3 м2 материала. Компания может получить до 1200 м2 материала в неделю. Для изготовления одной полки типа А требуется 12 мин машинного времени, а для изготовления одной полки типа В - 30 мин; машину можно использовать 160 час в неделю. Если прибыль от продажи полок типа А составляет 3 денежных единицы, а от полок типа В - 4 ден. ед., то сколько полок каждого типа следует выпускать в неделю?

f = 3х1 + 4х2 → max,
х1 + х2 ≤ 550,
2х1 + 3х2 ≤ 1200,
12х1 + 30х2 ≤ 9600, x1 ≥ 0, x2 ≥ 0.

В этой задаче 3 и 4 - кф целевой функции, [1, 1] - кф ограничений а11 и а12, 550 - b1, [2, 3] - a21 и а22, 1200 - b2, [12, 30] - a31 и a32, 9600 - b3
"""
    label.textAlignment = .center
    label.numberOfLines = 0
    view.addSubview(label)
    label.snp.makeConstraints { make in
        make.edges.equalToSuperview().inset(20)
    }
    
    let popUp = FFPopup(contentView: view, showType: .bounceInFromBottom, dismissType: .bounceOutToTop, maskType: .clear, dismissOnBackgroundTouch: true, dismissOnContentTouch: true)
    popUp.isUserInteractionEnabled = true
    let layout = FFPopupLayout(horizontal: .center, vertical: .center)
    popUp.show(layout: layout, duration: 10.0)
    
  }
}
