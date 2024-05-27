//
//  InputViewController.swift
//  kSolver
//
//  Created by Nikita Stepanov on 23.05.2024.
//

import UIKit
import SnapKit

class InputViewController: UIViewController {
    var objectiveTextFields: [UITextField] = []
    var constraintTextFields: [[UITextField]] = []
    var numberOfVariables: Int = 2
    var numberOfConstraints: Int = 3
    let mainView = InputView()

    let titleLabel = UILabel()
    let variablesControlLabel = UILabel()
    let constraintsControlLabel = UILabel()
    let increaseVariablesButton = UIButton(type: .system)
    let decreaseVariablesButton = UIButton(type: .system)
    let increaseConstraintsButton = UIButton(type: .system)
    let decreaseConstraintsButton = UIButton(type: .system)
    let objectiveContainer = UIView()
    let constraintsContainer = UIView()
    
    public var maximize = true

    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.delegate = self
        view = mainView
    }
}


extension InputViewController: InputViewDelegate {
    func back() {
        dismiss(animated: true)
    }
    
    func showInvalidNumberPopUp() {
        let alert = UIAlertController(title: "Ошибка", message: "Проверьте поля ввода!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
    
    func pushData(solver: SimplexSolver) {
        let resultViewController = ResultViewController()
        resultViewController.simplexSolver = solver
        resultViewController.maximize = maximize
        resultViewController.modalPresentationStyle = .fullScreen
        present(resultViewController, animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
