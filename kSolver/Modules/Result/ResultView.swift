//
//  ResultView.swift
//  kSolver
//
//  Created by Nikita Stepanov on 26.05.2024.
//

import Foundation
import UIKit

class ResultView: BaseView {
    var tableView: UITableView!
    var backButton: UIButton!
    var tableLabel: UILabel!
    
    var delegate: ResultViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        backgroundColor = .white
        setupTableView()
        
        let backButton = StandartButton()
        backButton.setTitle("Назад", for: .normal)
        backButton.addTarget(self, action: #selector(solveButtonTapped), for: .touchUpInside)
        frameView.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.bottom.equalTo(frameView.snp.bottom).inset(20)
            make.centerX.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(30)
            make.bottom.equalToSuperview().offset(-20)
        }
    }

    func setupTableView() {
        tableLabel = BaseLabel()
        tableLabel.text = "Таблица итераций метода симплекса:"
        tableLabel.tintColor = .black
        tableLabel.textAlignment = .center
        frameView.addSubview(tableLabel)
        tableLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(35)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }

        tableView = UITableView(frame: bounds, style: .plain)
        tableView.backgroundColor = .clear
        frameView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(frameView.snp.top).inset(100)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(100)
        }
    }
    
    @objc func solveButtonTapped() {
        delegate?.back()
    }
}


protocol ResultViewDelegate {
    func back()
}
