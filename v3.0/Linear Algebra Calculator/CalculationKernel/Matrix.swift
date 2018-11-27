//
//  Matrix.swift
//  Linear Algebra Calculator
//
//  Created by 王浩宇 on 2018/5/10.
//  Copyright © 2018年 UCAS Developers. All rights reserved.
//

import Foundation

public struct Matrix {
  public var rows: Int
  public var columns: Int
  var grid: [NSDecimalNumber]
}

let round = NSDecimalNumberHandler(roundingMode: NSDecimalNumber.RoundingMode.bankers, scale: 20, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: true)

let roundPE = NSDecimalNumberHandler(roundingMode: NSDecimalNumber.RoundingMode.bankers, scale: 16, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: true)

extension NSDecimalNumber {
    public var getIntPart: NSDecimalNumber {
        get {
            let stringArray = self.stringValue.components(separatedBy: ".")
            return NSDecimalNumber(string: stringArray[0])
        }
    }
}

func + (left: NSDecimalNumber, right: NSDecimalNumber) -> NSDecimalNumber {
    return left.adding(right, withBehavior: round)
}

func - (left: NSDecimalNumber, right: NSDecimalNumber) -> NSDecimalNumber {
    return left.subtracting(right, withBehavior: round)
}

func * (left: NSDecimalNumber, right: NSDecimalNumber) -> NSDecimalNumber {
    return left.multiplying(by: right, withBehavior: round)
}

func / (left: NSDecimalNumber, right: NSDecimalNumber) -> NSDecimalNumber {
    return left.dividing(by: right, withBehavior: round)
}

prefix func - (right: NSDecimalNumber) -> NSDecimalNumber {
    return right.multiplying(by: -1, withBehavior: round)
}

func += (left: inout NSDecimalNumber, right: NSDecimalNumber) {
    left = left.adding(right, withBehavior: round)
}

func -= (left: inout NSDecimalNumber, right: NSDecimalNumber) {
    left = left.subtracting(right, withBehavior: round)
}

func *= (left: inout NSDecimalNumber, right: NSDecimalNumber) {
    left = left.multiplying(by: right, withBehavior: round)
}

func /= (left: inout NSDecimalNumber, right: NSDecimalNumber) {
    left = left.dividing(by: right, withBehavior: round)
}

func > (left: NSDecimalNumber, right: NSDecimalNumber) -> Bool {
    let r = left.compare(right)
    if r == .orderedDescending {
        return true
    }
    else {
        return false
    }
}

func < (left: NSDecimalNumber, right: NSDecimalNumber) -> Bool {
    let r = left.compare(right)
    if r == .orderedAscending {
        return true
    }
    else {
        return false
    }
}

func >= (left: NSDecimalNumber, right: NSDecimalNumber) -> Bool {
    let r = left.compare(right)
    if r == .orderedDescending || r == .orderedSame {
        return true
    }
    else {
        return false
    }
}

func <= (left: NSDecimalNumber, right: NSDecimalNumber) -> Bool {
    let r = left.compare(right)
    if r == .orderedAscending || r == .orderedSame {
        return true
    }
    else {
        return false
    }
}

func == (left: NSDecimalNumber, right: NSDecimalNumber) -> Bool {
    if left > right || left < right {
        return false
    }
    else {
        return true
    }
}

func fabs(_ ns: NSDecimalNumber) -> NSDecimalNumber {
    if ns >= NSDecimalNumber(floatLiteral: 0) {
        return ns
    }
    else {
        return ns.multiplying(by: -1, withBehavior: round)
    }
}

//new declared init function
extension Matrix {
    public init(rows: Int, columns: Int, repeatedValue: NSDecimalNumber) {
        self.rows = rows
        self.columns = columns
        self.grid = [NSDecimalNumber].init(repeating: repeatedValue, count: rows * columns)
    }
}

//subscript
extension Matrix {
    public subscript(row: Int, column: Int) -> NSDecimalNumber {
        get { return grid[(row - 1) * columns + column - 1] }
        set { grid[(row - 1) * columns + column - 1] = newValue }
    }
}

//some functions
extension Matrix {
    public func transpose() -> Matrix {
        var results = Matrix(rows: columns, columns: rows, repeatedValue: 0)
        let matrix = self
        
        for j in 1...matrix.columns {
            for i in 1...matrix.rows {
                results[j, i] = matrix[i, j]
            }
        }
        
        return results
    }
}

infix operator <*> : MultiplicationPrecedence

public func <*> (A: Matrix, B: Matrix) -> Matrix {
    precondition(A.columns == B.rows, "Cannot multiply \(A.rows)×\(A.columns) matrix and \(B.rows)×\(B.columns) matrix")
    
    var result = Matrix.init(rows: A.rows, columns: B.columns, repeatedValue: 0)
    
    for i in 1...result.rows {
        for j in 1...result.columns {
            for a in 1...A.columns {
                result[i, j] += A[i, a] * B[a, j]
            }
        }
    }
    
    return result
}

public func + (A: Matrix, B: Matrix) -> Matrix {
    
    precondition(A.rows == B.rows, "error, matrices must have the same size!")
    precondition(A.columns == B.columns, "error, matrices must have the same size!")
    
    var result = Matrix.init(rows: A.rows, columns: A.columns, repeatedValue: 0)
    
    for i in 1...result.rows {
        for j in 1...result.columns {
            result[i, j] = A[i, j] + B[i, j]
        }
    }
    
    return result
}

public func - (A: Matrix, B: Matrix) -> Matrix {
    
    precondition(A.rows == B.rows, "error, matrices must have the same size!")
    precondition(A.columns == B.columns, "error, matrices must have the same size!")
    
    var result = Matrix.init(rows: A.rows, columns: A.columns, repeatedValue: 0)
    
    for i in 1...result.rows {
        for j in 1...result.columns {
            result[i, j] = A[i, j] - B[i, j]
        }
    }
    
    return result
}


extension Matrix {
    
    public func gauss() -> (Matrix, NSDecimalNumber) {
        
        var c: NSDecimalNumber
        var sign: NSDecimalNumber = 1
        var triangle = self
        var containerRow: [NSDecimalNumber] = []
        
        for j in 1...triangle.rows {
            //Column Pivot Algorithm
            if j < triangle.rows && j <= triangle.columns {
                for i in j + 1...triangle.rows {
                    if fabs(triangle[j, j]) < fabs(triangle[i, j]) {
                        for loop in 1...triangle.columns {
                            containerRow.append(triangle[i, loop])
                            triangle[i, loop] = triangle[j, loop]
                            triangle[j, loop] = containerRow[loop - 1]
                        }
                        sign *= -1
                        containerRow = []
                    }
                }
            }
            if j <= triangle.columns {
                if triangle[j, j] == 0 {
                    continue
                }
            }
            //Gauss Elimination
            for i in 1...triangle.rows {
                if i > j && j <= triangle.columns {
                    c = triangle[i, j] / triangle[j, j]
                    for k in 1...triangle.columns {
                        triangle[i, k] -= c * triangle[j, k]
                    }
                }
            }
        }
        
        processError(&triangle.grid)
        return (triangle, sign)
    }
    
    public func gauss2() -> Matrix {
        
        var triangle = self
        var mainElementRow = 1
        var process: NSDecimalNumber
        
        for j in 1...triangle.columns {
            //Column Pivot Algorithm
            if mainElementRow < triangle.rows {
                for i in mainElementRow + 1...triangle.rows {
                    if fabs(triangle[mainElementRow, j]) < fabs(triangle[i, j]) {
                        var temp: NSDecimalNumber
                        for loop in 1...triangle.columns {
                            temp = triangle[i, loop]
                            triangle[i, loop] = triangle[mainElementRow, loop]
                            triangle[mainElementRow, loop] = temp
                        }
                    }
                }
            }
            if triangle[mainElementRow, j] == 0 {
                continue
            }
            
            //Gaussian Elimination
            if mainElementRow < triangle.rows {
                for i in mainElementRow + 1...triangle.rows {
                    process = triangle[i, j] / triangle[mainElementRow, j]
                    for column in j...triangle.columns {
                        triangle[i, column] -= triangle[mainElementRow, column] * process
                    }
                }
            }
            
            mainElementRow += 1
            
            if mainElementRow == triangle.rows || triangle.rows == 1 {
                break
            }
        }
        
        processError(&triangle.grid)
        return triangle
    }
    
    public func determinant() -> NSDecimalNumber {
        
        var (triangle, sign) = self.gauss()
        var det: NSDecimalNumber = 1
        
        for i in 1...triangle.rows {
            det *= triangle[i, i]
        }
        
        det *= sign
        
        return det
    }
    
    public func rank() -> Int {
        
        var triangle = self.gauss2()
        
        var count = 0
        
        for i in 1...triangle.rows {
            for j in 1...triangle.columns {
                if triangle[i, j] != 0 {
                    count += 1
                    break
                }
            }
        }
        
        return count
    }
    
    public func adjointMatrix() -> Matrix {
        
        let matrix = self
        var cofactor: Matrix
        var adjoint = Matrix.init(rows: matrix.rows, columns: matrix.columns, repeatedValue: 0)
        var grid: [NSDecimalNumber] = []
        
        for i in 1...matrix.rows {
            for j in 1...matrix.columns {
                
                for a in 1...matrix.rows {
                    for b in 1...matrix.columns {
                        if a != i && b != j {
                            grid.append(matrix[a, b])
                        }
                    }
                }
                
                cofactor = Matrix.init(rows: matrix.rows - 1, columns: matrix.columns - 1, grid: grid)
                
                if (i + j) % 2 == 0 {
                    adjoint[i, j] = cofactor.determinant()
                }
                else {
                    adjoint[i, j] = -cofactor.determinant()
                }
                
                grid = []
            }
        }
        
        return adjoint.transpose()
    }
    
    public func minimalPolynomial() -> String {
        
        let matrix = self
        var triangle: Matrix
        let n = matrix.rows
        var loop = 0
        var matrixLoop = matrix
        var matrixFinal = matrix
        var count: Int
        var forRank: Matrix
        var gridArray: [NSDecimalNumber] = []
        var possibleNotZero = 0
        var zeroCount = 0
        var gridToSolve: [NSDecimalNumber] = []
        let augmentedMatrix: Matrix
        var triangle2: Matrix
        var x: [NSDecimalNumber] = []
        var sum: NSDecimalNumber = 0
        var result: [NSDecimalNumber] = []
        
        if matrix.rows != matrix.columns {
            return "只有方阵才能计算极小多项式哦～！"
        }
        
        if matrix.rows > 5 {
            return "抱歉，您输入的矩阵太复杂了，本计算器算不了呢～！"
        }
        
        var coefficientMatrix = Matrix.init(rows: matrix.rows * matrix.rows, columns: matrix.rows + 1, repeatedValue: 0)
        
        for a in 1...n {
            for j in loop * n + 1...(loop + 1) * n {
                if j - loop * n == a {
                    coefficientMatrix[j, n + 1] = 1
                }
                else {
                    coefficientMatrix[j, n + 1] = 0
                }
            }
            loop += 1
        }
        
        for i in (1...coefficientMatrix.columns - 1).reversed()  {
            
            if coefficientMatrix.columns - i - 1 > 0 {
                for _ in 1...coefficientMatrix.columns - i - 1 {
                    matrixLoop = matrixLoop <*> matrix
                    matrixFinal = matrixLoop
                }
            }
            
            matrixLoop = matrix
            
            for j in 1...coefficientMatrix.rows {
                coefficientMatrix[j, i] = matrixFinal.grid[j - 1]
            }
        }
        
        triangle = coefficientMatrix.gauss2()
        
        for i in 0..<triangle.grid.count {
            if triangle.grid[i] > NSDecimalNumber(integerLiteral: Int.max) {
                return "抱歉，您输入的矩阵太复杂了，本计算器算不了呢～！"
            }
        }
        
        count = triangle.columns - triangle.rank()
        
        var limitedColumns: [Int] = []
        
        var coefficient2DArray = [[NSDecimalNumber]].init(repeating: [0], count: triangle.columns)
        
        for i in 1...triangle.columns {
            var coefficientArray:[NSDecimalNumber] = []
            for _ in 1...count {
                coefficientArray.append(0)
            }
            coefficient2DArray[i - 1] = coefficientArray
        }
        
        for i in 1...triangle.rows {
            for j in 1...triangle.columns {
                if triangle[i, j] != 0 {
                    if !limitedColumns.contains(j) {
                        limitedColumns.append(j)
                    }
                    break
                }
            }
        }
        
        var freeColumns: [Int] = []
        
        for j in 1...triangle.columns {
            if !limitedColumns.contains(j) {
                freeColumns.append(j)
            }
        }
        
        var forLoop = 0
        
        for i in freeColumns {
            coefficient2DArray[i - 1][forLoop] = 1
            forLoop += 1
        }
        
        limitedColumns.reverse()
        
        var process: NSDecimalNumber = 0
        var targetRow: Int = 1
        
        for j in limitedColumns {
            
            for i in (1...triangle.rows).reversed() {
                if triangle[i, j] != 0 {
                    targetRow = i
                    break
                }
            }
            
            for a in 0..<count {
                for b in 1...triangle.columns {
                    if b != j {
                        process += -triangle[targetRow, b] * coefficient2DArray[b - 1][a]
                    }
                }
                coefficient2DArray[j - 1][a] = process / triangle[targetRow, j]
                process = 0
            }
        }
        
        for a in 0..<coefficient2DArray.count {
            processError(&coefficient2DArray[a])
        }
        
        for a in 0..<count {
            gridArray.append(coefficient2DArray[0][a])
        }
        
        for i in 1..<triangle.columns {
            
            if zeroCount < triangle.columns - i {
                zeroCount = 0
                for j in 1...triangle.columns - i {
                    
                    for a in 0..<count {
                        gridArray.append(coefficient2DArray[i + j - 1][a])
                    }
                    
                    forRank = Matrix.init(rows: i + 1, columns: count, grid: gridArray)
                    
                    if forRank.rank() == forRank.rows - 1 {
                        for _ in 1...count {
                            gridArray.remove(at: gridArray.count - 1)
                        }
                        zeroCount += 1
                        continue
                    }
                    else if forRank.rank() == forRank.rows {
                        possibleNotZero = i + j - 1
                        break
                    }
                }
            }
            else {
                break
            }
        }
        
        for i in 0...possibleNotZero {
            
            for j in 0..<count {
                gridToSolve.append(coefficient2DArray[i][j])
            }
            
            if i == possibleNotZero {
                gridToSolve.append(1)
            }
            else {
                gridToSolve.append(0)
            }
        }
        
        augmentedMatrix = Matrix.init(rows: possibleNotZero + 1, columns: count + 1, grid: gridToSolve)
        (triangle2, _) = augmentedMatrix.gauss()
        
        var coefficientT2:[NSDecimalNumber] = []
        
        for a in 1...triangle2.rows {
            for j in 1..<triangle2.columns {
                coefficientT2.append(triangle2[a, j])
            }
        }
        
        let coefficientTriangle2 = Matrix.init(rows: triangle2.rows, columns: triangle2.columns - 1, grid: coefficientT2)
        if coefficientTriangle2.rank() < coefficientTriangle2.columns {
            return "抱歉，您输入的矩阵太复杂了，本计算器算不了呢～！"
        }
        
        var i = triangle2.rows - 1
        let n1 = triangle2.rows
        
        for j in 0..<n1 {
            if triangle2[n1 - j, triangle2.columns - 1] == 0 {
                i -= 1
                continue
            }
            else {
                x.append(triangle2[n1 - j, triangle2.columns] / triangle2[n1 - j, triangle2.columns - 1])
                break
            }
        }
        
        while i >= 1 {
            sum = 0
            for j in i + 1...(triangle2.columns - 1) {
                sum += triangle2[i, j] * x[j - i - 1]
            }
            x.insert(((triangle2[i, triangle2.columns] - sum) / triangle2[i, i]), at: 0)
            i -= 1
        }
        
        var processResult: NSDecimalNumber = 0
        
        for i in 0..<triangle.columns {
            for j in 0..<count {
                processResult += x[j] * coefficient2DArray[i][j]
            }
            result.append(processResult)
            processResult = 0
        }
        
        processError(&result)
        
        var resultToString:String
        
        for i in 0..<result.count {
            resultToString = result[i].stringValue
            while resultToString.count > 10 {
                resultToString.remove(at: resultToString.index(before: resultToString.endIndex))
            }
            result[i] = NSDecimalNumber(string: resultToString)
        }
        
        processError(&result)
        
        var outputString: String = "μA = "
        
        if triangle.columns == 2 {
            for i in 0..<result.count {
                
                if result[i] == 0 {
                    continue
                }
                
                if i == 0 {
                    if result[i] == 1 {
                        outputString.append("t")
                    }
                    else if result[i] == -1 {
                        outputString.append("-t")
                    }
                    else {
                        outputString.append("\(result[i])t")
                    }
                }
                else {
                    if result[i] > 0 {
                        if outputString.last! == " " {
                            outputString.append("\(result[i])")
                        }
                        else {
                            outputString.append("+\(result[i])")
                        }
                    }
                    else {
                        if outputString.last! == " " {
                            outputString.append("\(result[i])")
                        }
                        else {
                            outputString.append("\(result[i])")
                        }
                    }
                }
            }
            return outputString
        }
        
        if triangle.columns == 3 {
            for i in 0..<result.count {
                
                if result[i] == 0 {
                    continue
                }
                
                if i == 0 {
                    if result[i] == 1 {
                        outputString.append("t²")
                    }
                    else if result[i] == -1 {
                        outputString.append("-t²")
                    }
                    else {
                        outputString.append("\(result[i])t²")
                    }
                }
                else {
                    if result[i] > 0 {
                        if outputString.last! == " " {
                            if i == 1 {
                                if result[i] == 1 {
                                    outputString.append("t")
                                }
                                else {
                                    outputString.append("\(result[i])t")
                                }
                            }
                            else {
                                outputString.append("\(result[i])")
                            }
                        }
                        else {
                            if i == 1 {
                                if result[i] == 1 {
                                    outputString.append("+t")
                                }
                                else {
                                    outputString.append("+\(result[i])t")
                                }
                            }
                            else {
                                outputString.append("+\(result[i])")
                            }
                        }
                    }
                    else {
                        if outputString.last! == " " {
                            if i == 1 {
                                if result[i] == -1 {
                                    outputString.append("-t")
                                }
                                else {
                                    outputString.append("\(result[i])t")
                                }
                            }
                            else {
                                outputString.append("\(result[i])")
                            }
                        }
                        else {
                            if i == 1 {
                                if result[i] == -1 {
                                    outputString.append("-t")
                                }
                                else {
                                    outputString.append("\(result[i])t")
                                }
                            }
                            else {
                                outputString.append("\(result[i])")
                            }
                        }
                    }
                }
            }
            return outputString
        }
        
        if triangle.columns == 4 {
            for i in 0..<result.count {
                
                if result[i] == 0 {
                    continue
                }
                
                if i == 0 {
                    if result[i] == 1 {
                        outputString.append("t³")
                    }
                    else if result[i] == -1 {
                        outputString.append("-t³")
                    }
                    else {
                        outputString.append("\(result[i])t³")
                    }
                }
                else {
                    if result[i] > 0 {
                        if outputString.last! == " " {
                            if i == 1 {
                                if result[i] == 1 {
                                    outputString.append("t²")
                                }
                                else {
                                    outputString.append("\(result[i])t²")
                                }
                            }
                            else if i == 2 {
                                if result[i] == 1 {
                                    outputString.append("t")
                                }
                                else {
                                    outputString.append("\(result[i])t")
                                }
                            }
                            else {
                                outputString.append("\(result[i])")
                            }
                        }
                        else {
                            if i == 1 {
                                if result[i] == 1 {
                                    outputString.append("+t²")
                                }
                                else {
                                    outputString.append("+\(result[i])t²")
                                }
                            }
                            else if i == 2 {
                                if result[i] == 1 {
                                    outputString.append("+t")
                                }
                                else {
                                    outputString.append("+\(result[i])t")
                                }
                            }
                            else {
                                outputString.append("+\(result[i])")
                            }
                        }
                    }
                    else {
                        if outputString.last! == " " {
                            if i == 1 {
                                if result[i] == -1 {
                                    outputString.append("-t²")
                                }
                                else {
                                    outputString.append("\(result[i])t²")
                                }
                            }
                            else if i == 2 {
                                if result[i] == -1 {
                                    outputString.append("-t")
                                }
                                else {
                                    outputString.append("\(result[i])t")
                                }
                            }
                            else {
                                outputString.append("\(result[i])")
                            }
                        }
                        else {
                            if i == 1 {
                                if result[i] == -1 {
                                    outputString.append("-t²")
                                }
                                else {
                                    outputString.append("\(result[i])t²")
                                }
                            }
                            else if i == 2 {
                                if result[i] == -1 {
                                    outputString.append("-t")
                                }
                                else {
                                    outputString.append("\(result[i])t")
                                }
                            }
                            else {
                                outputString.append("\(result[i])")
                            }
                        }
                    }
                }
            }
            return outputString
        }
        
        if triangle.columns == 5 {
            for i in 0..<result.count {
                
                if result[i] == 0 {
                    continue
                }
                
                if i == 0 {
                    if result[i] == 1 {
                        outputString.append("t⁴")
                    }
                    else if result[i] == -1 {
                        outputString.append("-t⁴")
                    }
                    else {
                        outputString.append("\(result[i])t⁴")
                    }
                }
                else {
                    if result[i] > 0 {
                        if outputString.last! == " " {
                            if i == 1 {
                                if result[i] == 1 {
                                    outputString.append("t³")
                                }
                                else {
                                    outputString.append("\(result[i])t³")
                                }
                            }
                            else if i == 2 {
                                if result[i] == 1 {
                                    outputString.append("t²")
                                }
                                else {
                                    outputString.append("\(result[i])t²")
                                }
                            }
                            else if i == 3 {
                                if result[i] == 1 {
                                    outputString.append("t")
                                }
                                else {
                                    outputString.append("\(result[i])t")
                                }
                            }
                            else {
                                outputString.append("\(result[i])")
                            }
                        }
                        else {
                            if i == 1 {
                                if result[i] == 1 {
                                    outputString.append("+t³")
                                }
                                else {
                                    outputString.append("+\(result[i])t³")
                                }
                            }
                            else if i == 2 {
                                if result[i] == 1 {
                                    outputString.append("+t²")
                                }
                                else {
                                    outputString.append("+\(result[i])t²")
                                }
                            }
                            else if i == 3 {
                                if result[i] == 1 {
                                    outputString.append("+t")
                                }
                                else {
                                    outputString.append("+\(result[i])t")
                                }
                            }
                            else {
                                outputString.append("+\(result[i])")
                            }
                        }
                    }
                    else {
                        if outputString.last! == " " {
                            if i == 1 {
                                if result[i] == -1 {
                                    outputString.append("-t³")
                                }
                                else {
                                    outputString.append("\(result[i])t³")
                                }
                            }
                            else if i == 2 {
                                if result[i] == -1 {
                                    outputString.append("-t²")
                                }
                                else {
                                    outputString.append("\(result[i])t²")
                                }
                            }
                            else if i == 3 {
                                if result[i] == -1 {
                                    outputString.append("-t")
                                }
                                else {
                                    outputString.append("\(result[i])t")
                                }
                            }
                            else {
                                outputString.append("\(result[i])")
                            }
                        }
                        else {
                            if i == 1 {
                                if result[i] == -1 {
                                    outputString.append("-t³")
                                }
                                else {
                                    outputString.append("\(result[i])t³")
                                }
                            }
                            else if i == 2 {
                                if result[i] == -1 {
                                    outputString.append("-t²")
                                }
                                else {
                                    outputString.append("\(result[i])t²")
                                }
                            }
                            else if i == 3 {
                                if result[i] == -1 {
                                    outputString.append("-t")
                                }
                                else {
                                    outputString.append("\(result[i])t")
                                }
                            }
                            else {
                                outputString.append("\(result[i])")
                            }
                        }
                    }
                }
            }
            return outputString
        }
        
        if triangle.columns == 6 {
            for i in 0..<result.count {
                
                if result[i] == 0 {
                    continue
                }
                
                if i == 0 {
                    if result[i] == 1 {
                        outputString.append("t⁵")
                    }
                    else if result[i] == -1 {
                        outputString.append("-t⁵")
                    }
                    else {
                        outputString.append("\(result[i])t⁵")
                    }
                }
                else {
                    if result[i] > 0 {
                        if outputString.last! == " " {
                            if i == 1 {
                                if result[i] == 1 {
                                    outputString.append("t⁴")
                                }
                                else {
                                    outputString.append("\(result[i])t⁴")
                                }
                            }
                            else if i == 2 {
                                if result[i] == 1 {
                                     outputString.append("t³")
                                }
                                else {
                                    outputString.append("\(result[i])t³")
                                }
                            }
                            else if i == 3 {
                                if result[i] == 1 {
                                    outputString.append("t²")
                                }
                                else {
                                    outputString.append("\(result[i])t²")
                                }
                            }
                            else if i == 4 {
                                if result[i] == 1 {
                                    outputString.append("t")
                                }
                                else {
                                    outputString.append("\(result[i])t")
                                }
                            }
                            else {
                                outputString.append("\(result[i])")
                            }
                        }
                        else {
                            if i == 1 {
                                if result[i] == 1 {
                                    outputString.append("+t⁴")
                                }
                                else {
                                    outputString.append("+\(result[i])t⁴")
                                }
                            }
                            else if i == 2 {
                                if result[i] == 1 {
                                    outputString.append("+t³")
                                }
                                else {
                                    outputString.append("+\(result[i])t³")
                                }
                            }
                            else if i == 3 {
                                if result[i] == 1 {
                                    outputString.append("+t²")
                                }
                                else {
                                    outputString.append("+\(result[i])t²")
                                }
                            }
                            else if i == 4 {
                                if result[i] == 1 {
                                    outputString.append("+t")
                                }
                                else {
                                    outputString.append("+\(result[i])t")
                                }
                            }
                            else {
                                outputString.append("+\(result[i])")
                            }
                        }
                    }
                    else {
                        if outputString.last! == " " {
                            if i == 1 {
                                if result[i] == -1 {
                                    outputString.append("-t⁴")
                                }
                                else {
                                    outputString.append("\(result[i])t⁴")
                                }
                            }
                            else if i == 2 {
                                if result[i] == -1 {
                                    outputString.append("-t³")
                                }
                                else {
                                    outputString.append("\(result[i])t³")
                                }
                            }
                            else if i == 3 {
                                if result[i] == -1 {
                                    outputString.append("-t²")
                                }
                                else {
                                    outputString.append("\(result[i])t²")
                                }
                            }
                            else if i == 4 {
                                if result[i] == -1 {
                                    outputString.append("-t")
                                }
                                else {
                                    outputString.append("\(result[i])t")
                                }
                            }
                            else {
                                outputString.append("\(result[i])")
                            }
                        }
                        else {
                            if i == 1 {
                                if result[i] == -1 {
                                    outputString.append("-t⁴")
                                }
                                else {
                                    outputString.append("\(result[i])t⁴")
                                }
                            }
                            else if i == 2 {
                                if result[i] == -1 {
                                    outputString.append("-t³")
                                }
                                else {
                                    outputString.append("\(result[i])t³")
                                }
                            }
                            else if i == 3 {
                                if result[i] == -1 {
                                    outputString.append("-t²")
                                }
                                else {
                                    outputString.append("\(result[i])t²")
                                }
                            }
                            else if i == 4 {
                                if result[i] == -1 {
                                    outputString.append("-t")
                                }
                                else {
                                    outputString.append("\(result[i])t")
                                }
                            }
                            else {
                                outputString.append("\(result[i])")
                            }
                        }
                    }
                }
            }
            return outputString
        }
        
        return "μA = 异常！"
    }
    
    public func Hessenberg() -> Matrix {
        
        var matrix = self
        var n = matrix.rows
        var ret = Matrix.init(rows: n, columns: n, repeatedValue: 0)
        var temp: NSDecimalNumber
        var maxNumber: Int
        
        n -= 1
        var i: Int
        
        for k in 1..<n {
            i = k - 1
            maxNumber = k
            temp = fabs(matrix[k + 1, i + 1])
            for j in k + 1..<n + 1 {
                if fabs(matrix[j + 1, i + 1]) > temp {
                    maxNumber = j
                }
            }
            ret[1, 1] = matrix[maxNumber + 1, i + 1]
            i = maxNumber
            if ret[1, 1] != 0 {
                if i != k {
                    for j in k - 1..<n + 1 {
                        temp = matrix[i + 1, j + 1]
                        matrix[i + 1, j + 1] = matrix[k + 1, j + 1]
                        matrix[k + 1, j + 1] = temp
                    }
                    for j in 0..<n + 1 {
                        temp = matrix[j + 1, i + 1]
                        matrix[j + 1, i + 1] = matrix[j + 1, k + 1]
                        matrix[j + 1, k + 1] = temp
                    }
                }
                for i in k + 1..<n + 1 {
                    temp = matrix[i + 1, k] / ret[1, 1]
                    matrix[i + 1, k] = 0
                    for j in k..<n + 1 {
                        matrix[i + 1, j + 1] -= temp * matrix[k + 1, j + 1]
                    }
                    for j in 0..<n + 1 {
                        matrix[j + 1, k + 1] += temp * matrix[j + 1, i + 1]
                    }
                }
            }
        }
        for i in 0..<n + 1 {
            for j in 0..<n + 1 {
                ret[i + 1, j + 1] = matrix[i + 1, j + 1]
            }
        }
        n += 1
        
        return ret
    }
    
    public func NearlyGetMatrixR() -> Matrix {
        
        let matrix = self
        assert(matrix.rank() == matrix.columns, "Rank should equal with columns!")
        var nearlyR = Matrix.init(rows: matrix.rows, columns: matrix.columns, repeatedValue: 0)
        var sum = [NSDecimalNumber].init(repeating: 0, count: nearlyR.rows)
        var columnVector = [NSDecimalNumber].init(repeating: 0, count: matrix.rows)
        
        for i in 1...matrix.columns {
            
            for j in 1...matrix.rows {
                columnVector[j - 1] = matrix[j, i]
            }
            
            if i == 1 {
                
                for j in 1...nearlyR.rows {
                    nearlyR[j, i] = columnVector[j - 1]
                }
            }
            else {
                for a in 1..<i {
                    
                    var knownBase = [NSDecimalNumber].init(repeating: 0, count: nearlyR.rows)
                    
                    for j in 1...nearlyR.rows {
                        knownBase[j - 1] = nearlyR[j, a]
                    }
                    
                    let numToMul = vectorMul(columnVector, knownBase) / (vectorNorm(knownBase) * vectorNorm(knownBase))
                    let vectorToSum = vectorMulNum(knownBase, numToMul)
                    sum = vectorAdd(sum, vectorToSum)
                }
                
                let newKnownBase = vectorSub(columnVector, sum)
                
                for j in 1...nearlyR.rows {
                    nearlyR[j, i] = newKnownBase[j - 1]
                }
            }
            
            sum = [NSDecimalNumber].init(repeating: 0, count: nearlyR.rows)
        }
        
        return nearlyR
    }
    
    // Based on Gram Schmidt Orthogonalization
    public func QRdecomposition() -> (Matrix, Matrix) {
        
        var matrix = self
        var nearlyR = matrix.NearlyGetMatrixR() // m x n
        let Q = matrix.GramSchmidtOrthogonalization() // m x n
        var R = Matrix.init(rows: matrix.columns, columns: matrix.columns, repeatedValue: 0) // n x n
        var vector = [NSDecimalNumber].init(repeating: 0, count: nearlyR.rows)
        var originVector = [NSDecimalNumber].init(repeating: 0, count: matrix.rows)
        
        for i in 1...R.rows {
            
            for a in 1...nearlyR.rows {
                vector[a - 1] = nearlyR[a, i]
            }
            
            for j in 1...R.columns {
                
                for a in 1...matrix.rows {
                    originVector[a - 1] = matrix[a, j]
                }
                
                if i == j {
                    R[i, j] = vectorNorm(vector)
                }
                else if i < j {
                    R[i, j] = vectorMul(originVector, vector)
                }
                else {
                    R[i, j] = 0
                }
            }
        }
        
        for i in 1...R.rows {
            for j in 1...R.columns {
                if i < j {
                    R[i, j] /= R[i, i]
                }
            }
        }
        
        return (Q, R)
    }
    
    public func isDiagAllZero(_ matrix: Matrix) -> Bool {
        assert(matrix.rows == matrix.columns, "Matrix must be square!")
        for i in 1...matrix.rows {
            if matrix[i, i] != 0 {
                return false
            }
        }
        return true
    }
    
    public func eigenValue() -> [NSDecimalNumber] {
        
        let matrix = self
        let diagAllZeroCheck = isDiagAllZero(matrix)
        var recursion = matrix
        var count = 1
        var Q: Matrix = Matrix.init(rows: 1, columns: 1, repeatedValue: 0)
        var R: Matrix = Matrix.init(rows: 1, columns: 1, repeatedValue: 0)
        var result: [NSDecimalNumber] = []
        
        if diagAllZeroCheck == true {
            for i in 1...recursion.rows {
                recursion[i, i] -= 1
            }
        }
        
        while count != 2001 {
            (Q, R) = recursion.QRdecomposition()
            recursion = R <*> Q
            count += 1
        }
        
        if diagAllZeroCheck == true {
            for i in 1...recursion.rows {
                recursion[i, i] += 1
            }
        }
        
        // processing error
        for i in 0..<recursion.grid.count {
            if fabs(recursion.grid[i]) - fabs(recursion.grid[i].getIntPart) <= 0.01 || fabs(recursion.grid[i]) - (fabs(recursion.grid[i].getIntPart) + 1) <= 0.01 || fabs(recursion.grid[i]) - (fabs(recursion.grid[i].getIntPart) - 1) <= 0.01 {
                if fabs(recursion.grid[i]) - fabs(recursion.grid[i].getIntPart) <= 0.01 && fabs(recursion.grid[i]) - fabs(recursion.grid[i].getIntPart) >= -0.01 {
                    recursion.grid[i] = recursion.grid[i].getIntPart
                }
                else if fabs(recursion.grid[i]) - (fabs(recursion.grid[i].getIntPart) + 1) <= 0.01 && fabs(recursion.grid[i]) - (fabs(recursion.grid[i].getIntPart) + 1) >= -0.01 {
                    if recursion.grid[i] < 0 {
                        recursion.grid[i] = recursion.grid[i].getIntPart - 1
                    }
                    else {
                        recursion.grid[i] = recursion.grid[i].getIntPart + 1
                    }
                }
                else if fabs(recursion.grid[i]) - (fabs(recursion.grid[i].getIntPart) - 1) <= 0.01 && fabs(recursion.grid[i]) - (fabs(recursion.grid[i].getIntPart) - 1) >= -0.01 {
                    recursion.grid[i] = recursion.grid[i].getIntPart + 1
                }
            }
        }
        
        for i in 1...recursion.rows {
            
            if i == 1 {
                result.append(recursion[i, i])
            }
            else if !result.contains(recursion[i, i]) {
                result.append(recursion[i, i])
            }
        }
        
        var loop = 0
        
        for i in 0..<result.count {
            if i == result.count {
                break
            }
            for j in 0..<result.count {
                if j == loop {
                    continue
                }
                else {
                    if result[loop] == result[j] {
                        result.remove(at: loop)
                        loop -= 1
                        break
                    }
                }
            }
            loop += 1
        }
        
        return result
    }
    
    public func eigenValueAndVector() -> ([[[NSDecimalNumber]]], [NSDecimalNumber]) {
        
        let matrix = self
        var diagonalMatrix = Matrix.init(rows: matrix.rows, columns: matrix.columns, repeatedValue: 0)
        var coefficientMatrix = Matrix.init(rows: matrix.rows, columns: matrix.columns, repeatedValue: 0)
        let eigenValueArray = matrix.eigenValue()
        var eigenVectorArray = [[[NSDecimalNumber]]].init(repeating: [[0]], count: eigenValueArray.count)
        var triangle: Matrix = Matrix.init(rows: 1, columns: 1, repeatedValue: 0)
        var count: Int = 0
        
        for i in 0..<eigenValueArray.count {
            if eigenValueArray[i] == 0 {
                return ([], [0])
            }
        }
        
        for i in 0..<eigenVectorArray.count {
            
            for j in 1...matrix.rows {
                diagonalMatrix[j, j] = eigenValueArray[i]
            }
            
            coefficientMatrix = diagonalMatrix - matrix
            triangle = coefficientMatrix.gauss2()
            
            count = triangle.columns - triangle.rank()
            
            if count == 0 {     //when complex numbers appear
                return ([], [0])
            }
            
            var limitedColumns: [Int] = []
            
            var coefficient2DArray = [[NSDecimalNumber]].init(repeating: [0], count: triangle.columns)
            
            for i in 1...triangle.columns {
                var coefficientArray:[NSDecimalNumber] = []
                for _ in 1...count {
                    coefficientArray.append(0)
                }
                coefficient2DArray[i - 1] = coefficientArray
            }
            
            for i in 1...triangle.rows {
                for j in 1...triangle.columns {
                    if triangle[i, j] != 0 {
                        if !limitedColumns.contains(j) {
                            limitedColumns.append(j)
                        }
                        break
                    }
                }
            }
            
            var freeColumns: [Int] = []
            
            for j in 1...triangle.columns {
                if !limitedColumns.contains(j) {
                    freeColumns.append(j)
                }
            }
            
            var forLoop = 0
            
            for i in freeColumns {
                coefficient2DArray[i - 1][forLoop] = 1
                forLoop += 1
            }
            
            limitedColumns.reverse()
            
            var process: NSDecimalNumber = 0
            var targetRow: Int = 1
            
            for j in limitedColumns {
                
                for i in (1...triangle.rows).reversed() {
                    if triangle[i, j] != 0 {
                        targetRow = i
                        break
                    }
                }
                
                for a in 0..<count {
                    for b in 1...triangle.columns {
                        if b != j {
                            process += -triangle[targetRow, b] * coefficient2DArray[b - 1][a]
                        }
                    }
                    coefficient2DArray[j - 1][a] = process / triangle[targetRow, j]
                    process = 0
                }
            }
            
            for a in 0..<coefficient2DArray.count {
                processError(&coefficient2DArray[a])
            }
            
            eigenVectorArray[i] = coefficient2DArray
        }
        
        return (eigenVectorArray, eigenValueArray)
    }
    
    public func Jordan() -> Matrix {
        
        let matrix = self
        let zeroMatrix = Matrix.init(rows: 1, columns: 1, repeatedValue: 0)
        let eigenValueArray = matrix.eigenValue()
        var jordan = Matrix.init(rows: matrix.rows, columns: matrix.columns, repeatedValue: 0)
        var matrixForEachEigenValue: Matrix = Matrix.init(rows: 1, columns: 1, repeatedValue: 0)
        var diagonalMatrix = Matrix.init(rows: matrix.rows, columns: matrix.columns, repeatedValue: 0)
        var N: Int = 0
        var countArrayForEachOrder: [Int] = []
        var count: Int = 0
        var matrixJPlus1: Matrix = Matrix.init(rows: 1, columns: 1, repeatedValue: 0)
        var matrixJ: Matrix = Matrix.init(rows: 1, columns: 1, repeatedValue: 0)
        var matrixJMinus1: Matrix = Matrix.init(rows: 1, columns: 1, repeatedValue: 0)
        var identityMatrix = Matrix.init(rows: matrix.rows, columns: matrix.columns, repeatedValue: 0)
        var twoDimensionalArrayForEachEigenValue: [[Int]] = []
        
        for i in 1...identityMatrix.rows {
            identityMatrix[i, i] = 1
        }
        
        for i in 0..<eigenValueArray.count {
            if !(fabs(eigenValueArray[i]) - fabs(eigenValueArray[i].getIntPart) < 0.000001) || eigenValueArray[i] == 0 {
                return zeroMatrix
            }
        }
        
        for i in eigenValueArray {
            
            for a in 1...diagonalMatrix.rows {
                diagonalMatrix[a, a] = i
            }
            
            matrixForEachEigenValue = matrix - diagonalMatrix
            N = matrix.rows - matrixForEachEigenValue.rank()
            matrixJ = matrixForEachEigenValue
            matrixJPlus1 = matrixForEachEigenValue
            matrixJMinus1 = matrixForEachEigenValue
            
            for j in 1...matrix.rows {
                
                count = 0
                
                if j == 1 {
                    matrixJMinus1 = identityMatrix
                    matrixJPlus1 = matrixJPlus1 <*> matrixJPlus1
                }
                else {
                    if j > 2 {
                        matrixJMinus1 = matrixJMinus1 <*> matrixJMinus1
                    }
                    else {
                        matrixJMinus1 = matrixForEachEigenValue
                    }
                    
                    matrixJ = matrixJ <*> matrixJ
                    matrixJPlus1 = matrixJPlus1 <*> matrixJPlus1
                    
                }
                
                countArrayForEachOrder.append(matrixJPlus1.rank() + matrixJMinus1.rank() - 2 * matrixJ.rank())
                
                for a in 0..<countArrayForEachOrder.count {
                    count += countArrayForEachOrder[a]
                }
                
                if count == N {
                    break
                }
            }
            
            twoDimensionalArrayForEachEigenValue.append(countArrayForEachOrder)
            countArrayForEachOrder = []
        }
        
        var rowCount = 1
        var eigenValueCount = 0
        var oneCount = 0
        
        for eigenValue in twoDimensionalArrayForEachEigenValue {
            for j in 0..<eigenValue.count {
                if eigenValue[j] > 0 {
                    for _ in 1...(j + 1) * eigenValue[j] {
                        jordan[rowCount, rowCount] = eigenValueArray[eigenValueCount]
                        if j + 1 > 1 {
                            if oneCount != j {
                                jordan[rowCount, rowCount + 1] = 1
                                oneCount += 1
                            }
                        }
                        rowCount += 1
                    }
                }
                oneCount = 0
            }
            eigenValueCount += 1
        }
        
        return jordan
    }
    
    public func processError(_ array: inout [NSDecimalNumber]) {
        
        for i in 0..<array.count {
            if fabs(array[i]) - fabs(array[i].getIntPart) < 0.000001 || fabs(array[i]) - (fabs(array[i].getIntPart) + 1) < 0.000001 || fabs(array[i]) - (fabs(array[i].getIntPart) - 1) < 0.000001 {
                if fabs(array[i]) - (array[i].getIntPart) < 0.000001 && fabs(array[i]) - fabs(array[i].getIntPart) > -0.000001 {
                    array[i] = array[i].getIntPart
                }
                else if fabs(array[i]) - (fabs(array[i].getIntPart) + 1) < 0.000001 && fabs(array[i]) - (fabs(array[i].getIntPart) + 1) > -0.000001 {
                    if array[i] < 0 {
                        array[i] = array[i].getIntPart - 1
                    }
                    else {
                        array[i] = array[i].getIntPart + 1
                    }
                }
                else if fabs(array[i]) - (fabs(array[i].getIntPart) - 1) < 0.000001 && fabs(array[i]) - (fabs(array[i].getIntPart) - 1) > -0.000001 {
                    array[i] = array[i].getIntPart + 1
                }
            }
        }
    }
    
    public func GramSchmidtOrthogonalization() -> Matrix {
        
        let matrix = self
        assert(matrix.rank() == matrix.columns, "Rank should equal with columns!")
        var orthonormalBasis = Matrix.init(rows: matrix.rows, columns: matrix.columns, repeatedValue: 0)
        var sum = [NSDecimalNumber].init(repeating: 0, count: orthonormalBasis.rows)
        var columnVector = [NSDecimalNumber].init(repeating: 0, count: matrix.rows)
        var norm: NSDecimalNumber = 0
        
        for i in 1...matrix.columns {
            
            for j in 1...matrix.rows {
                columnVector[j - 1] = matrix[j, i]
            }
            
            if i == 1 {
                
                norm = vectorNorm(columnVector)
                columnVector = vectorDivNum(columnVector, norm)
                
                for j in 1...orthonormalBasis.rows {
                    orthonormalBasis[j, i] = columnVector[j - 1]
                }
            }
            else {
                for a in 1..<i {
                    
                    var knownBase = [NSDecimalNumber].init(repeating: 0, count: orthonormalBasis.rows)
                    
                    for j in 1...orthonormalBasis.rows {
                        knownBase[j - 1] = orthonormalBasis[j, a]
                    }
                    
                    let numToMul = vectorMul(columnVector, knownBase)
                    let vectorToSum = vectorMulNum(knownBase, numToMul)
                    sum = vectorAdd(sum, vectorToSum)
                }
                
                var newKnownBase = vectorSub(columnVector, sum)
                newKnownBase = vectorDivNum(newKnownBase, vectorNorm(newKnownBase))
                
                for j in 1...orthonormalBasis.rows {
                    orthonormalBasis[j, i] = newKnownBase[j - 1]
                }
            }
            
            sum = [NSDecimalNumber].init(repeating: 0, count: orthonormalBasis.rows)
        }
        
        return orthonormalBasis
    }
    
    public func vectorNorm(_ vector: [NSDecimalNumber]) -> NSDecimalNumber {
        var sum: NSDecimalNumber = 0
        for i in 0..<vector.count {
            sum += vector[i] * vector[i]
        }
        return NSDecimalNumber(floatLiteral: Darwin.sqrt(sum.doubleValue))
    }
    
    public func vectorDivNum(_ vector: [NSDecimalNumber], _ num: NSDecimalNumber) -> [NSDecimalNumber] {
        
        var newVector = [NSDecimalNumber].init(repeating: 0, count: vector.count)
        for i in 0..<vector.count {
            newVector[i] = vector[i] / num
        }
        return newVector
    }
    
    public func vectorMul(_ vector1: [NSDecimalNumber], _ vector2: [NSDecimalNumber]) -> NSDecimalNumber {
        assert(vector1.count == vector2.count, "the numbers of elements must be equal!")
        var value: NSDecimalNumber = 0
        for i in 0..<vector1.count {
            value += vector1[i] * vector2[i]
        }
        return value
    }
    
    public func vectorMulNum(_ vector: [NSDecimalNumber], _ num: NSDecimalNumber) -> [NSDecimalNumber] {
        var newVector = [NSDecimalNumber].init(repeating: 0, count: vector.count)
        for i in 0..<vector.count {
            newVector[i] = vector[i] * num
        }
        return newVector
    }
    
    public func vectorAdd(_ vector1: [NSDecimalNumber], _ vector2: [NSDecimalNumber]) -> [NSDecimalNumber] {
        assert(vector1.count == vector2.count, "the numbers of elements must be equal!")
        var newVector = [NSDecimalNumber].init(repeating: 0, count: vector1.count)
        for i in 0..<vector1.count {
            newVector[i] = vector1[i] + vector2[i]
        }
        return newVector
    }
    
    public func vectorSub(_ vector1: [NSDecimalNumber], _ vector2: [NSDecimalNumber]) -> [NSDecimalNumber] {
        assert(vector1.count == vector2.count, "the numbers of elements must be equal!")
        var newVector = [NSDecimalNumber].init(repeating: 0, count: vector1.count)
        for i in 0..<vector1.count {
            newVector[i] = vector1[i] - vector2[i]
        }
        return newVector
    }
}
