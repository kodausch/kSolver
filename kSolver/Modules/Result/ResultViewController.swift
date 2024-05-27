//
//  ResultViewController.swift
//  kSolver
//
//  Created by Nikita Stepanov on 23.05.2024.
//

import UIKit

class ResultViewController: UIViewController, UITableViewDataSource {
    var simplexSolver: SimplexSolver?
    var outputView: ResultView!
    var maximize = true

    override func viewDidLoad() {
        super.viewDidLoad()
        outputView = ResultView(frame: view.bounds)
        view.addSubview(outputView)
        outputView.tableView.dataSource = self
        outputView.delegate = self
        simplexSolver?.solve()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        displayResults()
    }

    func displayResults() {
        guard let simplexSolver = simplexSolver else { return }

        let alert = UIAlertController(title: "Решение:", message: "Значение целевой функции: \(simplexSolver.getObjectiveValue())\nЗначения перменных: \(simplexSolver.getSolution())", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return simplexSolver?.tableau.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        guard let row = simplexSolver?.tableau[indexPath.row] else { return cell }
        cell.textLabel?.text = row.map { String(format: "%.2f", $0) }.joined(separator: ", ")
        cell.textLabel?.textColor = .red
        cell.backgroundColor = .lightGray
        return cell
    }
}

extension ResultViewController: ResultViewDelegate {
    func back() {
        dismiss(animated: true)
    }
}
