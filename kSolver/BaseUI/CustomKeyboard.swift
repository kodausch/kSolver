//
//  CustomKeyBoard.swift
//  kSolver
//
//  Created by Nikita Stepanov on 26.05.2024.
//

import Foundation
import UIKit

class DigitButton: UIButton {
    var digit: Int = 0
}

class NumericKeyboard: UIView {
    weak var target: (UIResponder & UIKeyInput & UITextInput)?
    
    lazy var displayLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.backgroundColor = .lightGray
        label.textColor = .black
        label.text = ""
        return label
    }()
    
    lazy var decimalButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(".", for: .normal)
        button.titleLabel?.font = K.font
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(didTapDecimalButton(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var returnButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Дальше", for: .normal)
        button.titleLabel?.font = K.font
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(didTapReturnButton(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var changeSignButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("±", for: .normal)
        button.titleLabel?.font = UIFont(name: K.fontName, size: 24)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = .red
            button.layer.cornerRadius = 5
            button.layer.masksToBounds = true
            button.addTarget(self, action: #selector(didTapChangeSignButton(_:)), for: .touchUpInside)
            return button
        }()
    
    lazy var numericButtons: [DigitButton] = (0...9).map {
        let button = DigitButton(type: .system)
        button.digit = $0
        button.setTitle("\($0)", for: .normal)
        button.titleLabel?.font = UIFont(name: K.fontName, size: 24)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(didTapDigitButton(_:)), for: .touchUpInside)
        return button
    }
    
    var deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Удалить", for: .normal)
        button.titleLabel?.font = K.font
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(didTapDeleteButton(_:)), for: .touchUpInside)
        return button
    }()
    
    init(target: UIResponder & UIKeyInput & UITextInput) {
        self.target = target
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Actions

extension NumericKeyboard {
    @objc func didTapDigitButton(_ sender: DigitButton) {
        insertText("\(sender.digit)")
    }
    
    @objc func didTapDecimalButton(_ sender: UIButton) {
        insertText(".")
    }
    
    @objc func didTapReturnButton(_ sender: UIButton) {
        target?.resignFirstResponder()
    }
    
    @objc func didTapDeleteButton(_ sender: UIButton) {
        target?.deleteBackward()
        updateDisplayLabel()
    }
    
    @objc func didTapChangeSignButton(_ sender: UIButton) {
            guard let textInput = target else { return }
            
            if let textField = textInput as? UITextField, var text = textField.text {
                if text.hasPrefix("-") {
                    text.removeFirst()
                } else {
                    text = "-" + text
                }
                textField.text = text
            } else if let textView = textInput as? UITextView, var text = textView.text {
                if text.hasPrefix("-") {
                    text.removeFirst()
                } else {
                    text = "-" + text
                }
                textView.text = text
            }
            updateDisplayLabel()
        }
}

// MARK: - Private initial configuration methods

private extension NumericKeyboard {
    func configure() {
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addButtons()
    }
    
    func addButtons() {
        let stackView = createStackView(axis: .vertical)
        stackView.frame = bounds
        stackView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
            stackView.isLayoutMarginsRelativeArrangement = true
        
        addSubview(stackView)
        
        stackView.addArrangedSubview(displayLabel)
        
        for row in 0 ..< 3 {
            let subStackView = createStackView(axis: .horizontal)
            stackView.addArrangedSubview(subStackView)
            
            for column in 0 ..< 3 {
                subStackView.addArrangedSubview(numericButtons[row * 3 + column + 1])
            }
        }
        
        let subStackView = createStackView(axis: .horizontal)
        stackView.addArrangedSubview(subStackView)
        
        subStackView.addArrangedSubview(numericButtons[0])
        subStackView.addArrangedSubview(decimalButton)
        subStackView.addArrangedSubview(returnButton)
        subStackView.addArrangedSubview(changeSignButton)
        subStackView.addArrangedSubview(deleteButton)
    }
    
    func createStackView(axis: NSLayoutConstraint.Axis) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = axis
        stackView.alignment = .fill
        stackView.spacing = 5
        stackView.distribution = .fillEqually
        return stackView
    }
    
    func insertText(_ string: String) {
        target?.insertText(string)
        updateDisplayLabel()
    }
    
    func updateDisplayLabel() {
        if let textField = target as? UITextField {
            displayLabel.text = textField.text
        } else if let textView = target as? UITextView {
            displayLabel.text = textView.text
        }
    }
}

// MARK: - UITextInput extension

extension UITextInput {
    var selectedRange: NSRange? {
        guard let textRange = selectedTextRange else { return nil }
        
        let location = offset(from: beginningOfDocument, to: textRange.start)
        let length = offset(from: textRange.start, to: textRange.end)
        return NSRange(location: location, length: length)
    }
}

