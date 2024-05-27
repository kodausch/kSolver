//
//  MenuViewController.swift
//  kSolver
//
//  Created by Nikita Stepanov on 26.05.2024.
//



import UIKit

class MenuViewController: UIViewController {
    private let mainView = MenuView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

private extension MenuViewController {
    
    func setupUI() {
        mainView.pattern1Button.addTarget(self, action: #selector(goToPattern1), for: .touchUpInside)
        mainView.pattern1InfoButton.addTarget(self, action: #selector(showPattern1Info), for: .touchUpInside)
    }
    
    @objc func goToPattern1() {
        let vc = InputViewController()
        vc.maximize = true
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    @objc func showPattern1Info() {
        showPopUp()
    }
}

