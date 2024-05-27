//
//  SimplexSolver.swift
//  kSolver
//
//  Created by Nikita Stepanov on 27.05.2024.
//

import Foundation

class SimplexSolver {
    var c: [Double]
    var A: [[Double]]
    var b: [Double]
    var tableau: [[Double]] = []
    var artificialVariables: [Int] = []

    init(c: [Double], A: [[Double]], b: [Double]) {
        self.c = c
        self.A = A
        self.b = b
        initializeTableau()
    }

    func initializeTableau() {
        let m = A.count
        let n = c.count
        tableau = Array(repeating: Array(repeating: 0.0, count: n + m + 1), count: m + 1)

        for i in 0..<m {
            for j in 0..<n {
                tableau[i][j] = A[i][j]
            }
            tableau[i][n + i] = 1.0
            tableau[i][n + m] = b[i]
            artificialVariables.append(n + i)
        }

        for j in 0..<n {
            tableau[m][j] = -c[j]
        }

        for i in 0..<m {
            tableau[m] = zip(tableau[m], tableau[i]).map { $0 - $1 }
        }
    }

    func solvePhase1() -> Bool {
        let m = A.count
        let n = c.count

        while true {
            let pivotColumn = tableau[m].firstIndex(where: { $0 < 0 }) ?? -1
            if pivotColumn == -1 {
                break
            }

            var pivotRow = -1
            var minRatio = Double.greatestFiniteMagnitude
            for i in 0..<m {
                if tableau[i][pivotColumn] > 0 {
                    let ratio = tableau[i][n + m] / tableau[i][pivotColumn]
                    if ratio < minRatio {
                        minRatio = ratio
                        pivotRow = i
                    }
                }
            }

            if pivotRow == -1 {
                return false
            }

            let pivotElement = tableau[pivotRow][pivotColumn]

            for j in 0..<(n + m + 1) {
                tableau[pivotRow][j] /= pivotElement
            }

            for i in 0...m {
                if i != pivotRow {
                    let factor = tableau[i][pivotColumn]
                    for j in 0..<(n + m + 1) {
                        tableau[i][j] -= factor * tableau[pivotRow][j]
                    }
                }
            }
        }

        for j in artificialVariables {
            if tableau[m][j] != 0 {
                return false
            }
        }
        return true
    }

    func solvePhase2() {
        let m = A.count
        let n = c.count

        // Remove artificial variables from the objective function
        for j in artificialVariables {
            tableau[m][j] = 0.0
        }

        while true {
            let pivotColumn = tableau[m].firstIndex(where: { $0 < 0 }) ?? -1
            if pivotColumn == -1 {
                break
            }

            var pivotRow = -1
            var minRatio = Double.greatestFiniteMagnitude
            for i in 0..<m {
                if tableau[i][pivotColumn] > 0 {
                    let ratio = tableau[i][n + m] / tableau[i][pivotColumn]
                    if ratio < minRatio {
                        minRatio = ratio
                        pivotRow = i
                    }
                }
            }

            if pivotRow == -1 {
                break
            }

            let pivotElement = tableau[pivotRow][pivotColumn]

            for j in 0..<(n + m + 1) {
                tableau[pivotRow][j] /= pivotElement
            }

            for i in 0...m {
                if i != pivotRow {
                    let factor = tableau[i][pivotColumn]
                    for j in 0..<(n + m + 1) {
                        tableau[i][j] -= factor * tableau[pivotRow][j]
                    }
                }
            }
        }
    }

    func solve() {
        if solvePhase1() {
            solvePhase2()
        } else {
            print("No feasible solution found.")
        }
    }

    func getSolution() -> [Double] {
        let m = A.count
        let n = c.count
        var solution = Array(repeating: 0.0, count: n)
        for i in 0..<m {
            for j in 0..<n {
                if tableau[i][j] == 1.0 {
                    solution[j] = tableau[i][n + m]
                    break
                }
            }
        }
        return solution
    }

    func getObjectiveValue() -> Double {
        let m = A.count
        let n = c.count
        return tableau[m][n + m]
    }
}



