//
//  InputView.swift
//  kSolver
//
//  Created by Nikita Stepanov on 24.05.2024.
//

import Foundation
import UIKit

class InputView: BaseView {
    var objectiveTextFields: [UITextField] = []
    var constraintTextFields: [[UITextField]] = []
    var numberOfVariables: Int = 2 {
        didSet {
            variablesControlLabel.text = "Количество переменных: \(numberOfVariables)"
        }
    }
    var numberOfConstraints: Int = 3 {
        didSet {
            constraintsControlLabel.text = "Количество ограничений: \(numberOfConstraints)"
        }
    }
    
    var delegate: InputViewDelegate? {
        didSet {
            for i in objectiveTextFields {
                i.delegate = delegate
            }
            
            for i in constraintTextFields {
                for g in i {
                    g.delegate = delegate
                }
            }
        }
    }

    let titleLabel = BaseLabel()
    let variablesControlLabel = BaseLabel()
    let constraintsControlLabel = BaseLabel()
    let increaseVariablesButton = StandartButton()
    let decreaseVariablesButton = StandartButton()
    let increaseConstraintsButton = StandartButton()
    let decreaseConstraintsButton = StandartButton()
    let objectiveContainer = UIView()
    let constraintsContainer = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStaticUI()
        increaseVariables()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupStaticUI() {
        
        backgroundColor = .purple
        
        titleLabel.text = "Введите данные задачи ЛП:"
        titleLabel.textAlignment = .center
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.centerX.equalToSuperview()
        }
        
        variablesControlLabel.text = "Количество переменных: 2"
        addSubview(variablesControlLabel)
        variablesControlLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        increaseVariablesButton.setTitle("+", for: .normal)
        increaseVariablesButton.tintColor = .white
        increaseVariablesButton.addTarget(self, action: #selector(increaseVariables), for: .touchUpInside)
        addSubview(increaseVariablesButton)
        increaseVariablesButton.snp.makeConstraints { make in
            make.centerY.equalTo(variablesControlLabel.snp.centerY)
            make.left.equalToSuperview().offset(50)
        }
        
        decreaseVariablesButton.setTitle("-", for: .normal)
        decreaseVariablesButton.tintColor = .white
        decreaseVariablesButton.addTarget(self, action: #selector(decreaseVariables), for: .touchUpInside)
        addSubview(decreaseVariablesButton)
        decreaseVariablesButton.snp.makeConstraints { make in
            make.centerY.equalTo(variablesControlLabel.snp.centerY)
            make.right.equalToSuperview().offset(-50)
        }
        
        constraintsControlLabel.text = "Количество ограничений: 3"
        addSubview(constraintsControlLabel)
        constraintsControlLabel.snp.makeConstraints { make in
            make.top.equalTo(increaseVariablesButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        increaseConstraintsButton.setTitle("+", for: .normal)
        increaseConstraintsButton.tintColor = .white
        increaseConstraintsButton.addTarget(self, action: #selector(increaseConstraints), for: .touchUpInside)
        addSubview(increaseConstraintsButton)
        increaseConstraintsButton.snp.makeConstraints { make in
            make.centerY.equalTo(constraintsControlLabel.snp.centerY)
            make.left.equalToSuperview().offset(50)
        }
        
        decreaseConstraintsButton.setTitle("-", for: .normal)
        decreaseConstraintsButton.tintColor = .white
        decreaseConstraintsButton.addTarget(self, action: #selector(decreaseConstraints), for: .touchUpInside)
        addSubview(decreaseConstraintsButton)
        decreaseConstraintsButton.snp.makeConstraints { make in
            make.centerY.equalTo(constraintsControlLabel.snp.centerY)
            make.right.equalToSuperview().offset(-50)
        }
        
        addSubview(objectiveContainer)
        objectiveContainer.snp.makeConstraints { make in
            make.top.equalTo(increaseConstraintsButton.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
        }
        
        addSubview(constraintsContainer)
        constraintsContainer.snp.makeConstraints { make in
            make.top.equalTo(objectiveContainer.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(20)
        }
    }

    func setupDynamicUI() {
        for subview in objectiveContainer.subviews {
            subview.removeFromSuperview()
        }
        for subview in constraintsContainer.subviews {
            subview.removeFromSuperview()
        }
        
        objectiveTextFields.removeAll()
        constraintTextFields.removeAll()
        
        let objectiveLabel = BaseLabel()
        objectiveLabel.text = "Кф целевой функции:"
        objectiveContainer.addSubview(objectiveLabel)
        objectiveLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        var lastInputView: UIView = objectiveLabel
        
        for i in 0..<numberOfVariables {
            let textField = UITextField()
            textField.delegate = delegate
            textField.placeholder = "c\(i + 1)"
            textField.borderStyle = .roundedRect
            textField.inputView = NumericKeyboard(target: textField)
            objectiveContainer.addSubview(textField)
            textField.snp.makeConstraints { make in
                make.top.equalTo(lastInputView.snp.bottom).offset(10)
                make.centerX.equalToSuperview()
                make.width.equalTo(100)
            }
            
            objectiveTextFields.append(textField)
            lastInputView = textField
        }
        
        let constraintsLabel = BaseLabel()
        constraintsLabel.text = "Кф ограничений:"
        constraintsLabel.textAlignment = .center
        constraintsContainer.addSubview(constraintsLabel)
        constraintsLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(30)
            make.centerX.equalToSuperview()
        }
        
        var lastConstraintView: UIView = constraintsLabel
        
        for i in 0..<numberOfConstraints {
            var rowTextFields: [UITextField] = []
            let rowStackView = UIStackView()
            rowStackView.axis = .horizontal
            rowStackView.distribution = .fillEqually
            rowStackView.spacing = 10
            constraintsContainer.addSubview(rowStackView)
            rowStackView.snp.makeConstraints { make in
                make.top.equalTo(lastConstraintView.snp.bottom).offset(10)
                make.left.right.equalToSuperview().inset(10)
            }
            
            for j in 0..<numberOfVariables {
                let textField = UITextField()
                textField.delegate = delegate
                textField.placeholder = "a\(i + 1)\(j + 1)"
                textField.borderStyle = .roundedRect
                textField.inputView = NumericKeyboard(target: textField)
                rowStackView.addArrangedSubview(textField)
                rowTextFields.append(textField)
            }
            
            let rhsTextField = UITextField()
            rhsTextField.delegate = delegate
            rhsTextField.placeholder = "b\(i + 1)"
            rhsTextField.borderStyle = .roundedRect
            rhsTextField.inputView = NumericKeyboard(target: rhsTextField)
            rowStackView.addArrangedSubview(rhsTextField)
            rowTextFields.append(rhsTextField)
            
            constraintTextFields.append(rowTextFields)
            lastConstraintView = rowStackView
        }
        
        let spacer = UIView()
        constraintsContainer.addSubview(spacer)
        spacer.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(50)
        }
        
        // Solve Button
        let solveButton = StandartButton()
        solveButton.setTitle("Решить", for: .normal)
        solveButton.addTarget(self, action: #selector(solveButtonTapped), for: .touchUpInside)
        constraintsContainer.addSubview(solveButton)
        solveButton.snp.makeConstraints { make in
            make.bottom.equalTo(frameView.snp.bottom).inset(20)
            make.right.equalToSuperview().inset(20)
            make.left.equalTo(spacer.snp.right).inset(20)
            make.bottom.equalToSuperview().offset(-20)
        }
        
        let backButton = StandartButton()
        backButton.setTitle("Назад", for: .normal)
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        constraintsContainer.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.top.equalTo(lastConstraintView.snp.bottom).offset(20)
            make.left.equalToSuperview().inset(20)
            make.right.equalTo(spacer.snp.left).inset(20)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
    @objc func back() {
        delegate?.back()
    }

    @objc func increaseVariables() {
        if numberOfVariables < 5 {
            numberOfVariables += 1
        }
        setupDynamicUI()
    }

    @objc func decreaseVariables() {
        if numberOfVariables > 1 {
            numberOfVariables -= 1
            setupDynamicUI()
        }
    }

    @objc func increaseConstraints() {
        if numberOfConstraints < 5 {
            numberOfConstraints += 1
        }
        setupDynamicUI()
    }

    @objc func decreaseConstraints() {
        if numberOfConstraints > 1 {
            numberOfConstraints -= 1
            setupDynamicUI()
        }
    }

    @objc func solveButtonTapped() {
        var c: [Double] = []
        var A: [[Double]] = []
        var b: [Double] = []

        for textField in objectiveTextFields {
            if let value = Double(textField.text ?? "") {
                c.append(value)
            }
        }

        for row in constraintTextFields {
            var constraint: [Double] = []
            for j in 0..<numberOfVariables {
                if let value = Double(row[j].text ?? "") {
                    constraint.append(value)
                }
            }
            A.append(constraint)
            if let value = Double(row[numberOfVariables].text ?? "") {
                b.append(value)
            }
        }

        // Проверка правильности ввода
        guard c.count == numberOfVariables, A.count == numberOfConstraints, b.count == numberOfConstraints else {
            let alert = UIAlertController(title: "Error", message: "Please enter valid numbers for all fields", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            delegate?.showInvalidNumberPopUp()
            return
        }
        let simplexSolver = SimplexSolver(c: c, A: A, b: b)
        delegate?.pushData(solver: simplexSolver)
    }
}


protocol InputViewDelegate: UITextFieldDelegate {
    func showInvalidNumberPopUp()
    func pushData(solver: SimplexSolver)
    func back()
}
