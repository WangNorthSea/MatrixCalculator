//
//  CalculatorEngine.swift
//  Linear Algebra Calculator
//
//  Created by 王浩宇 on 2018/5/26.
//  Copyright © 2018年 UCAS Developers. All rights reserved.
//

import UIKit

class CalculatorEngine: NSObject {

    var A: Matrix = Matrix.init(rows: 2, columns: 2, repeatedValue: 0)
    var B:Matrix?
    var C:Matrix?
    var expanded:Matrix?
    var storageString:String = ""
    var inputString:String = ""
    var gridStringArray:[String] = []
    let figureArray:Array<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", ".", "-", "/"]
    var gridArray:[Double] = []
    var check = false
    var decimal:Double = 0
    var decimalStringArray:[String] = []
    var dfCheck = true
    var dfCheck2 = true
    let numberFormatter = NumberFormatter()
    
    func createMatrixA(_ inputString:String, _ row:Int, _ column:Int) {
        for i in inputString {
            if figureArray.contains(i) {
                storageString.append(i)
                check = true
            }
            else if check {
                storageString.append(" ")
                check = false
            }
        }
        
        gridStringArray = storageString.components(separatedBy: " ")
        
        for i in 0..<gridStringArray.count {
            
            if gridStringArray[i].contains("/") {
                decimalStringArray = gridStringArray[i].components(separatedBy: "/")
                decimal = Double(decimalStringArray[0])! / Double(decimalStringArray[1])!
                gridStringArray[i] = String(decimal)
            }
        }
        
        for i in 0..<gridStringArray.count {
            gridArray.append(Double(gridStringArray[i])!)
        }
        
        A = Matrix.init(rows: row, columns: column, grid: gridArray)
        
        storageString = ""
        gridStringArray = []
        gridArray = []
    }
    
    func createMatrixB(_ inputString:String, _ row:Int, _ column:Int) {
        for i in inputString {
            if figureArray.contains(i) {
                storageString.append(i)
                check = true
            }
            else if check {
                storageString.append(" ")
                check = false
            }
        }
        gridStringArray = storageString.components(separatedBy: " ")
        
        for i in 0..<gridStringArray.count {
            
            if gridStringArray[i].contains("/") {
                decimalStringArray = gridStringArray[i].components(separatedBy: "/")
                decimal = Double(decimalStringArray[0])! / Double(decimalStringArray[1])!
                gridStringArray[i] = String(decimal)
            }
        }
        
        for i in 0..<gridStringArray.count {
            gridArray.append(Double(gridStringArray[i])!)
        }
        B = Matrix.init(rows: row, columns: column, grid: gridArray)
        storageString = ""
        gridStringArray = []
        gridArray = []
    }
    
    func transpose() {
        B = A.transpose()
    }
    
    func inverse2(_ input: String) -> String {
        
        var grid: [String]
        var up: Double
        var down: Double
        var exchange: Double
        var Gcd: Int
        var inputString: String
        var upToString: String
        var downToString: String
        var twoParts1: [String]
        var twoParts2: [String]
        
        if input.contains("/") {
            grid = input.components(separatedBy: "/")
            up = Double(grid[0])!
            down = Double(grid[1])!
            
            if up == 0 {
                return "您输入的矩阵不可逆～！"
            }
            
            if input.contains(".") {
               
               upToString = String(up)
               downToString = String(down)
               
                if downToString.contains(".") && !upToString.contains(".") {
                   
                    var loop = 0
                    
                    while loop < 5 {
                        twoParts2 = downToString.components(separatedBy: ".")
                        if twoParts2[1] == "0" {
                            break
                        }
                        else {
                            up *= 10
                            down *= 10
                            downToString = String(down)
                        }
                        loop += 1
                    }
                }
                else if !downToString.contains(".") && upToString.contains(".") {
                    
                    var loop = 0
                    
                    while loop < 5 {
                        twoParts1 = upToString.components(separatedBy: ".")
                        if twoParts1[1] == "0" {
                            break
                        }
                        else {
                            up *= 10
                            down *= 10
                            upToString = String(up)
                        }
                        loop += 1
                    }
                }
                else if downToString.contains(".") && upToString.contains(".") {
                    
                    var loop = 0
                    
                    while loop < 5 {
                        twoParts1 = upToString.components(separatedBy: ".")
                        twoParts2 = downToString.components(separatedBy: ".")
                        if twoParts1[1] == "0" && twoParts2[1] == "0" {
                            break
                        }
                        else {
                            up *= 10
                            down *= 10
                            upToString = String(up)
                            downToString = String(down)
                        }
                        loop += 1
                    }
                }
            }
            
            exchange = up
            up = down
            down = exchange
            
            upToString = String(up)
            downToString = String(down)
            upToString.remove(at: upToString.index(before: upToString.endIndex))
            upToString.remove(at: upToString.index(before: upToString.endIndex))
            downToString.remove(at: downToString.index(before: downToString.endIndex))
            downToString.remove(at: downToString.index(before: downToString.endIndex))
            
            if up * down < 0 {
                down = fabs(down)
                up = -fabs(up)
            }
            
            Gcd = gcd(Int(upToString)!, Int(downToString)!)
            up /= Double(abs(Gcd))
            down /= Double(abs(Gcd))
            
            upToString = String(up)
            downToString = String(down)
            upToString.remove(at: upToString.index(before: upToString.endIndex))
            upToString.remove(at: upToString.index(before: upToString.endIndex))
            downToString.remove(at: downToString.index(before: downToString.endIndex))
            downToString.remove(at: downToString.index(before: downToString.endIndex))
            
            if up == 0 {
                inputString = "您输入的矩阵不可逆～！"
            }
            else {
                if down == 1 {
                    inputString = String(up)
                }
                else {
                    inputString = "\(Int(upToString)!)/\(Int(downToString)!)"
                }
            }
        }
        else if input.contains(".") {
            up = 1
            down = Double(input)!
            var numberToString: String
            var twoParts: [String]
            
            numberToString = input
            
            var loop = 0
            
            while loop < 5 {
                
                twoParts = numberToString.components(separatedBy: ".")
                if twoParts[1] == "0" {
                    break
                }
                else {
                    up *= 10
                    down *= 10
                    numberToString = String(down)
                }
                loop += 1
            }
            
            upToString = String(up)
            downToString = String(down)
            upToString.remove(at: upToString.index(before: upToString.endIndex))
            upToString.remove(at: upToString.index(before: upToString.endIndex))
            downToString.remove(at: downToString.index(before: downToString.endIndex))
            downToString.remove(at: downToString.index(before: downToString.endIndex))
            
            if up * down < 0 {
                down = fabs(down)
                up = -fabs(up)
            }
            
            Gcd = gcd(Int(upToString)!, Int(downToString)!)
            up /= Double(abs(Gcd))
            down /= Double(abs(Gcd))
            
            upToString = String(up)
            downToString = String(down)
            upToString.remove(at: upToString.index(before: upToString.endIndex))
            upToString.remove(at: upToString.index(before: upToString.endIndex))
            downToString.remove(at: downToString.index(before: downToString.endIndex))
            downToString.remove(at: downToString.index(before: downToString.endIndex))
            
            if down == 0 {
                inputString = "您输入的矩阵不可逆～！"
            }
            else {
                if down == 1 {
                    inputString = String(up)
                }
                else {
                    inputString = "\(Int(upToString)!)/\(Int(downToString)!)"
                }
            }
        }
        else {
            up = 1
            down = Double(input)!
            
            if up * down < 0 {
                down = fabs(down)
                up = -fabs(up)
            }
            
            Gcd = gcd(Int(up), Int(down))
            up /= Double(abs(Gcd))
            down /= Double(abs(Gcd))
            
            if down == 0 {
                inputString = "您输入的矩阵不可逆～！"
            }
            else {
                if down == 1 {
                    inputString = String(up)
                }
                else {
                    inputString = "\(Int(up))/\(Int(down))"
                }
            }
        }
        
        return inputString
    }
    
    func inverse() -> String {
        
        var x:[Double] = []
        var sum:Double = 0
        var inputString = ""
        let loop = A.columns
        var grid: [Double] = []
        var triangle: Matrix
        var result: [String] = []
        
        if A.rank() != A.rows {
            
            return "您输入的矩阵不可逆～！"
        }
        
        for a in 1...loop {
            
            for i in 1...A.rows {
                for j in 1...A.columns + 1 {
                    
                    if j != A.columns + 1 {
                        grid.append(A[i, j])
                    }
                    else {
                        if i == a {
                            grid.append(1)
                        }
                        else {
                            grid.append(0)
                        }
                    }
                }
            }
            
            expanded = Matrix.init(rows: A.rows, columns: A.columns + 1, grid: grid)
            (triangle, _) = (expanded?.gauss())!
            
            processError(&triangle.grid)
            
            let n = triangle.rows
            var i = n - 1
            
            for j in 0..<n {
                if triangle[n - j, triangle.columns - 1] == 0 {
                    i -= 1
                    continue
                }
                else {
                    x.append(triangle[n - j, triangle.columns] / triangle[n - j, triangle.columns - 1])
                    break
                }
            }
            while i >= 1 {
                sum = 0
                for j in i + 1...(triangle.columns - 1) {
                    sum += triangle[i, j] * x[j - i - 1]
                }
                x.insert(((triangle[i, triangle.columns] - sum) / triangle[i, i]), at: 0)
                i -= 1
            }
            
            processError(&x)
            gridStringArray = decimalToFraction(x)
            
            for i in 0..<gridStringArray.count {
                result.append(gridStringArray[i])
            }
            
            gridStringArray = []
            grid = []
            x = []
        }
        
        var i  = 0
        
        for a in 1...A.rows {
            for _ in 1..<A.columns {
                inputString.append(result[i * A.rows + a - 1])
                inputString.append("   ")
                i += 1
            }
            inputString.append(result[i * A.rows + a - 1])
            i += 1
            if a != A.rows {
                inputString.append("\n")
                i = 0
            }
        }
        
        return inputString
    }
    
    func addition(_ matrix1: Matrix, _ matrix2: Matrix) -> String {
        
        C = matrix1 + matrix2
        
        return matrixToString(C!)
    }
    
    func subtraction(_ matrix1: Matrix, _ matrix2: Matrix) -> String {
        
        C = matrix1 - matrix2
        
        return matrixToString(C!)
    }
    
    func multiplication(_ matrix1: Matrix, _ matrix2: Matrix) -> String {
        
        C = matrix1 <*> matrix2
        
        return matrixToString(C!)
    }
    
    func determinant(_ matrix: Matrix) -> String {
        
        var inputString = ""
        var integer: Int
        var decimal: Double
        var decimalString: String
        var decimalArray: [String] = []
        var exchange: String
        var up: Int = 0
        var down: Int = 0
        var d: Int
        var n1: Int
        var n9: Int
        var tmp_up: Int
        var tmp_down: Int
        var s = 2
        var t: Int
        var countOfZero: Int
        var (triangle, sign) = matrix.gauss()
        var det: Double = 1
        
        processError(&triangle.grid)
        
        for i in 1...triangle.rows {
            det *= triangle[i, i]
        }
        
        det *= sign
        
        if fabs(det) - fabs(Double(Int(det))) < 0.000001 || fabs(det) - (fabs(Double(Int(det))) + 1) < 0.000001 || fabs(det) - (fabs(Double(Int(det))) - 1) < 0.000001 {
            if fabs(det) - fabs(Double(Int(det))) < 0.000001 && fabs(det) - fabs(Double(Int(det))) > -0.000001 {
                det = Double(Int(det))
            }
            else if fabs(det) - (fabs(Double(Int(det))) + 1) < 0.000001 && fabs(det) - (fabs(Double(Int(det))) + 1) > -0.000001 {
                if det < 0 {
                    det = Double(Int(det)) - 1
                }
                else {
                    det = Double(Int(det)) + 1
                }
            }
            else if fabs(det) - (fabs(Double(Int(det))) - 1) < 0.000001 && fabs(det) - (fabs(Double(Int(det))) - 1) > -0.000001 {
                det = Double(Int(det)) + 1
            }
        }
        
        inputString = String(det)
        var detToString = String(det)
        
        if !(fabs(det) - fabs(Double(Int(det))) < 0.0001 || fabs(det) - (fabs(Double(Int(det))) + 1) < 0.0001 || fabs(det) - (fabs(Double(Int(det))) - 1) < 0.0001) {
            
            while 1 == 1 {
                detToString.remove(at: detToString.index(before: detToString.endIndex))
                if detToString.contains(".") {
                    continue
                }
                else {
                    break
                }
            }
            
            integer = Int(detToString)!
            decimal = det - Double(integer)
            
            decimalString = String(decimal)
            
            while decimalString.count > 13 {
                decimalString.remove(at: decimalString.index(before: decimalString.endIndex))
            }
            
            while decimalString.last! == "0" {
                decimalString.remove(at: decimalString.index(before: decimalString.endIndex))
            }
            
            for j in decimalString {
                decimalArray.append(String(j))
            }
            
            if decimalArray.contains("e") {
                if decimalArray[0] != "-" {
                    exchange = decimalArray[0]
                    decimalArray[0] = decimalArray[1]
                    decimalArray[1] = exchange
                    
                    countOfZero = 10 * Int(Double(decimalArray[decimalArray.count - 2])!) + Int(Double(decimalArray[decimalArray.count - 1])!)
                    
                    for _ in 1..<countOfZero {
                        decimalArray.insert("0", at: 1)
                    }
                    
                    decimalArray.insert("0", at: 0)
                    
                    for _ in 1...4 {
                        decimalArray.remove(at: decimalArray.count - 1)
                    }
                }
                else {
                    exchange = decimalArray[1]
                    decimalArray[1] = decimalArray[2]
                    decimalArray[2] = exchange
                    
                    countOfZero = 10 * Int(Double(decimalArray[decimalArray.count - 2])!) + Int(Double(decimalArray[decimalArray.count - 1])!)
                    
                    for _ in 1..<countOfZero {
                        decimalArray.insert("0", at: 2)
                    }
                    
                    decimalArray.insert("0", at: 1)
                    
                    for _ in 1...4 {
                        decimalArray.remove(at: decimalArray.count - 1)
                    }
                }
            }
            
            while decimalArray.count > 13 {
                decimalArray.remove(at: decimalArray.count - 1)
            }
            
            if decimalArray.count > 12 {
                if decimalArray[0] != "-" {
                    s = 2
                    t = decimalArray.count - 3
                    up = getNum(s, t, decimalArray)
                    down = getNum9(t - s)
                    d = gcd(up, down)
                    up /= d
                    down /= d
                    
                    if up != 0 {
                        n1 = getNum(s, t, decimalArray)
                        n9 = getNum9(t - s)
                        
                        for a in s + 1..<t {
                            tmp_up = n1 - getNum(s, a, decimalArray)
                            tmp_down = n9 - getNum9(a - s)
                            d = gcd(tmp_down, tmp_up)
                            tmp_down /= d
                            tmp_up /= d
                            
                            if tmp_down < down {
                                down = tmp_down
                                up = tmp_up
                            }
                        }
                        up += integer * down
                        if down == 1 {
                            inputString = "\(up)"
                        }
                        else {
                            inputString = "\(up)/\(down)"
                        }
                    }
                }
                else {
                    s = 3
                    t = decimalArray.count - 4
                    up = getNum(s, t, decimalArray)
                    down = getNum9(t - s)
                    d = gcd(up, down)
                    up /= d
                    down /= d
                    
                    if up != 0 {
                        n1 = getNum(s, t, decimalArray)
                        n9 = getNum9(t - s)
                        
                        for a in s + 1..<t {
                            tmp_up = n1 - getNum(s, a, decimalArray)
                            tmp_down = n9 - getNum9(a - s)
                            d = gcd(tmp_down, tmp_up)
                            tmp_down /= d
                            tmp_up /= d
                            
                            if tmp_down < down {
                                down = tmp_down
                                up = tmp_up
                            }
                        }
                        up += -integer * down
                        if down == 1 {
                            inputString = "-\(up)"
                        }
                        else {
                            inputString = "-\(up)/\(down)"
                        }
                    }
                }
            }
            if !inputString.contains("/") {
                inputString = String(Double(integer) + Double(decimalString)!)
            }
        }
        
        return inputString
    }
    
    func rank(_ matrix: Matrix) -> String {
        
        return String(matrix.rank())
    }
    
    func trace(_ matrix: Matrix) -> String {
        
        var trace: Double = 0
        var inputString = ""
        var integer: Int
        var decimal: Double
        var decimalString: String
        var decimalArray: [String] = []
        var exchange: String
        var up: Int = 0
        var down: Int = 0
        var d: Int
        var n1: Int
        var n9: Int
        var tmp_up: Int
        var tmp_down: Int
        var s = 2
        var t: Int
        var countOfZero: Int
        
        for i in 1...matrix.rows {
            trace += matrix[i, i]
        }
        
        inputString = String(trace)
        var traceToString = String(trace)
        
        if !(fabs(trace) - fabs(Double(Int(trace))) < 0.0001 || fabs(trace) - (fabs(Double(Int(trace))) + 1) < 0.0001 || fabs(trace) - (fabs(Double(Int(trace))) - 1) < 0.0001) {
            
            while 1 == 1 {
                traceToString.remove(at: traceToString.index(before: traceToString.endIndex))
                if traceToString.contains(".") {
                    continue
                }
                else {
                    break
                }
            }
        
            integer = Int(traceToString)!
            decimal = trace - Double(integer)
            
            decimalString = String(decimal)
            
            while decimalString.count > 13 {
                decimalString.remove(at: decimalString.index(before: decimalString.endIndex))
            }
            
            while decimalString.last! == "0" {
                decimalString.remove(at: decimalString.index(before: decimalString.endIndex))
            }
            
            for j in decimalString {
                decimalArray.append(String(j))
            }
            
            if decimalArray.contains("e") {
                if decimalArray[0] != "-" {
                    exchange = decimalArray[0]
                    decimalArray[0] = decimalArray[1]
                    decimalArray[1] = exchange
                    
                    countOfZero = 10 * Int(Double(decimalArray[decimalArray.count - 2])!) + Int(Double(decimalArray[decimalArray.count - 1])!)
                    
                    for _ in 1..<countOfZero {
                        decimalArray.insert("0", at: 1)
                    }
                    
                    decimalArray.insert("0", at: 0)
                    
                    for _ in 1...4 {
                        decimalArray.remove(at: decimalArray.count - 1)
                    }
                }
                else {
                    exchange = decimalArray[1]
                    decimalArray[1] = decimalArray[2]
                    decimalArray[2] = exchange
                    
                    countOfZero = 10 * Int(Double(decimalArray[decimalArray.count - 2])!) + Int(Double(decimalArray[decimalArray.count - 1])!)
                    
                    for _ in 1..<countOfZero {
                        decimalArray.insert("0", at: 2)
                    }
                    
                    decimalArray.insert("0", at: 1)
                    
                    for _ in 1...4 {
                        decimalArray.remove(at: decimalArray.count - 1)
                    }
                }
            }
            
            while decimalArray.count > 13 {
                decimalArray.remove(at: decimalArray.count - 1)
            }
            
            if decimalArray.count > 12 {
                if decimalArray[0] != "-" {
                    s = 2
                    t = decimalArray.count - 3
                    up = getNum(s, t, decimalArray)
                    down = getNum9(t - s)
                    d = gcd(up, down)
                    up /= d
                    down /= d
                    
                    if up != 0 {
                        n1 = getNum(s, t, decimalArray)
                        n9 = getNum9(t - s)
                        
                        for a in s + 1..<t {
                            tmp_up = n1 - getNum(s, a, decimalArray)
                            tmp_down = n9 - getNum9(a - s)
                            d = gcd(tmp_down, tmp_up)
                            tmp_down /= d
                            tmp_up /= d
                            
                            if tmp_down < down {
                                down = tmp_down
                                up = tmp_up
                            }
                        }
                        up += integer * down
                        if down == 1 {
                            inputString = "\(up)"
                        }
                        else {
                            inputString = "\(up)/\(down)"
                        }
                    }
                }
                else {
                    s = 3
                    t = decimalArray.count - 4
                    up = getNum(s, t, decimalArray)
                    down = getNum9(t - s)
                    d = gcd(up, down)
                    up /= d
                    down /= d
                    
                    if up != 0 {
                        n1 = getNum(s, t, decimalArray)
                        n9 = getNum9(t - s)
                        
                        for a in s + 1..<t {
                            tmp_up = n1 - getNum(s, a, decimalArray)
                            tmp_down = n9 - getNum9(a - s)
                            d = gcd(tmp_down, tmp_up)
                            tmp_down /= d
                            tmp_up /= d
                            
                            if tmp_down < down {
                                down = tmp_down
                                up = tmp_up
                            }
                        }
                        up += -integer * down
                        if down == 1 {
                            inputString = "-\(up)"
                        }
                        else {
                            inputString = "-\(up)/\(down)"
                        }
                    }
                }
            }
            if !inputString.contains("/") {
                inputString = String(Double(integer) + Double(decimalString)!)
            }
        }
        
        return inputString
    }
    
    func solveLinearEquations(_ matrix: Matrix) -> String {
        
        var grid:[Double] = []
        var x:[Double] = []
        var sum:Double = 0
        let n = matrix.rows
        var i = n - 1
        var triangle = matrix.gauss2()
        var inputString = ""
        
        processError(&triangle.grid)
        
        for a in 1...matrix.rows {
            for j in 1..<matrix.columns {
                grid.append(matrix[a, j])
            }
        }
        
        let coefficient = Matrix.init(rows: matrix.rows, columns: matrix.columns - 1, grid: grid)
        
        if Int(rank(coefficient))! < Int(rank(matrix))! {
            return "该线性方程组无解～！"
        }
        else if Int(rank(coefficient))! == Int(rank(matrix))! && Int(rank(coefficient))! < coefficient.columns {
            
            let count = coefficient.columns - coefficient.rank()
            
            var limitedColumns: [Int] = []
            
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
            
            var triangleOfLimited = Matrix.init(rows: limitedColumns.count, columns: limitedColumns.count + 1, repeatedValue: 0)
            var Grid: [Double] = []
            
            for i in 1...triangle.rows {
                for j in 1...triangle.columns {
                    if limitedColumns.contains(j) || j == triangle.columns {
                        Grid.append(triangle[i, j])
                    }
                }
            }
            
            triangleOfLimited.grid = Grid
            
            for j in 0..<n {
                if triangleOfLimited[n - j, triangleOfLimited.columns - 1] == 0 {
                    i -= 1
                    continue
                }
                else {
                    x.append(triangleOfLimited[n - j, triangleOfLimited.columns] / triangleOfLimited[n - j, triangleOfLimited.columns - 1])
                    break
                }
            }
            while i >= 1 {
                sum = 0
                for j in i + 1...(triangleOfLimited.columns - 1) {
                    sum += triangleOfLimited[i, j] * x[j - i - 1]
                }
                x.insert(((triangleOfLimited[i, triangleOfLimited.columns] - sum) / triangleOfLimited[i, i]), at: 0)
                i -= 1
            }
            
            processError(&x)
            gridStringArray = decimalToFraction(x)
            gridStringArray = decimalToFraction2(&gridStringArray)
            
            var specialSolution: [String] = []
            var loop = 0
            
            for i in 0..<triangle.columns {
                if limitedColumns.contains(i + 1) {
                    specialSolution.append(gridStringArray[loop])
                    loop += 1
                }
                else {
                    specialSolution.append("0")
                }
            }
            
            gridStringArray = []
            
            var simplifiedStaircase = coefficient.gauss2()
            
            for i in 0..<simplifiedStaircase.grid.count {
                if fabs(simplifiedStaircase.grid[i]) - fabs(Double(Int(simplifiedStaircase.grid[i]))) < 0.000001 || fabs(simplifiedStaircase.grid[i]) - (fabs(Double(Int(simplifiedStaircase.grid[i]))) + 1) < 0.000001 || fabs(simplifiedStaircase.grid[i]) - (fabs(Double(Int(simplifiedStaircase.grid[i]))) - 1) < 0.000001 {
                    if fabs(simplifiedStaircase.grid[i]) - fabs(Double(Int(simplifiedStaircase.grid[i]))) < 0.000001 && fabs(simplifiedStaircase.grid[i]) - fabs(Double(Int(simplifiedStaircase.grid[i]))) > -0.000001 {
                        simplifiedStaircase.grid[i] = Double(Int(simplifiedStaircase.grid[i]))
                    }
                    else if fabs(simplifiedStaircase.grid[i]) - (fabs(Double(Int(simplifiedStaircase.grid[i]))) + 1) < 0.000001 && fabs(simplifiedStaircase.grid[i]) - (fabs(Double(Int(simplifiedStaircase.grid[i]))) + 1) > -0.000001 {
                        if simplifiedStaircase.grid[i] < 0 {
                            simplifiedStaircase.grid[i] = Double(Int(simplifiedStaircase.grid[i])) - 1
                        }
                        else {
                            simplifiedStaircase.grid[i] = Double(Int(simplifiedStaircase.grid[i])) + 1
                        }
                    }
                    else if fabs(simplifiedStaircase.grid[i]) - (fabs(Double(Int(simplifiedStaircase.grid[i]))) - 1) < 0.000001 && fabs(simplifiedStaircase.grid[i]) - (fabs(Double(Int(simplifiedStaircase.grid[i]))) - 1) > -0.000001 {
                        simplifiedStaircase.grid[i] = Double(Int(simplifiedStaircase.grid[i])) + 1
                    }
                }
            }
            
            var coefficient2DArray = [[Double]].init(repeating: [0], count: simplifiedStaircase.columns)
            var coefficient2DStringArray: [[String]] = []
            
            for i in 1...simplifiedStaircase.columns {
                var coefficientArray:[Double] = []
                for _ in 1...count {
                    coefficientArray.append(0)
                }
                coefficient2DArray[i - 1] = coefficientArray
            }
            
            let oneDimensionalArray = [String].init(repeating: "0", count: coefficient2DArray[0].count)
            
            for _ in 1...simplifiedStaircase.columns {
                coefficient2DStringArray.append(oneDimensionalArray)
            }
            
            for i in 1...simplifiedStaircase.rows {
                for j in 1...simplifiedStaircase.columns {
                    if simplifiedStaircase[i, j] != 0 {
                        if !limitedColumns.contains(j) {
                            limitedColumns.append(j)
                        }
                        break
                    }
                }
            }
            
            var freeColumns: [Int] = []
            
            for j in 1...simplifiedStaircase.columns {
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
            
            var process: Double = 0
            var targetRow: Int = 1
            
            for j in limitedColumns {
                
                for i in (1...simplifiedStaircase.rows).reversed() {
                    if simplifiedStaircase[i, j] != 0 {
                        targetRow = i
                        break
                    }
                }
                
                for a in 0..<count {
                    for b in 1...simplifiedStaircase.columns {
                        if b != j {
                            process += -simplifiedStaircase[targetRow, b] * coefficient2DArray[b - 1][a]
                        }
                    }
                    coefficient2DArray[j - 1][a] = process / simplifiedStaircase[targetRow, j]
                    process = 0
                }
            }
            
            for a in 0..<coefficient2DArray.count {
                
                processError(&coefficient2DArray[a])
                gridStringArray = decimalToFraction(coefficient2DArray[a])
                gridStringArray = decimalToFraction2(&gridStringArray)
                
                for b in 0..<coefficient2DStringArray[a].count {
                    coefficient2DStringArray[a][b] = gridStringArray[b]
                }
                
                gridStringArray = []
            }
            
            var outputString = ""
            
            for i in 0..<coefficient2DArray.count {
                outputString.append("x\(i + 1) = ")
                
                if !(specialSolution[i] == "0" || specialSolution[i] == "0.0" || specialSolution[i] == "-0.0") {
                    outputString.append(specialSolution[i])
                }
                
                var loopForZero = 0
                
                for g in 0..<coefficient2DArray[i].count {
                    if coefficient2DArray[i][g] == 0 {
                        loopForZero += 1
                    }
                    else {
                        break
                    }
                }
                
                if loopForZero == coefficient2DArray[i].count {
                    if outputString.last! == " " {
                        outputString.append("0.0")
                    }
                }
                
                for j in 0..<coefficient2DArray[i].count {
                    if coefficient2DArray[i][j] != 0 {
                        if coefficient2DArray[i][j] > 0 {
                            if coefficient2DArray[i][j] == 1 {
                                if outputString.last! != " " {
                                    outputString.append("+α\(j + 1)")
                                }
                                else {
                                    outputString.append("α\(j + 1)")
                                }
                            }
                            else {
                                if outputString.last! != " " {
                                    outputString.append("+\(coefficient2DStringArray[i][j])α\(j + 1)")
                                }
                                else {
                                    outputString.append("\(coefficient2DStringArray[i][j])α\(j + 1)")
                                }
                            }
                        }
                        else {
                            if coefficient2DArray[i][j] == -1 {
                                outputString.append("-α\(j + 1)")
                            }
                            else {
                                outputString.append("\(coefficient2DStringArray[i][j])α\(j + 1)")
                            }
                        }
                    }
                }
                
                if i != coefficient2DArray.count - 1 {
                    outputString.append("\n")
                }
            }
            
            return outputString
        }
        else if Int(rank(coefficient))! == Int(rank(matrix))! && Int(rank(coefficient))! == coefficient.columns {
            
            for j in 0..<n {
                if triangle[n - j, triangle.columns - 1] == 0 {
                    i -= 1
                    continue
                }
                else {
                    x.append(triangle[n - j, triangle.columns] / triangle[n - j, triangle.columns - 1])
                    break
                }
            }
            while i >= 1 {
                sum = 0
                for j in i + 1...(triangle.columns - 1) {
                    sum += triangle[i, j] * x[j - i - 1]
                }
                x.insert(((triangle[i, triangle.columns] - sum) / triangle[i, i]), at: 0)
                i -= 1
            }
            
            processError(&x)
            gridStringArray = decimalToFraction(x)
            
            for i in 1...x.count {
                inputString.append("x\(i) = \(gridStringArray[i - 1])\n")
            }
            inputString.remove(at: inputString.index(before: inputString.endIndex))
            gridStringArray = []
            return inputString
        }
        
        return "异常"
    }
    
    func matrixToString(_ matrix:Matrix) -> String {
        
        var Matrix = matrix
        var matrixString: String
        
        processError(&Matrix.grid)
        gridStringArray = decimalToFraction(Matrix.grid)
        
        var i = 0
        
        for a in 1...matrix.rows {
            for _ in 1..<matrix.columns {
                inputString.append(gridStringArray[i])
                inputString.append("   ")
                i += 1
            }
            inputString.append(gridStringArray[i])
            i += 1
            if a != matrix.rows {
                inputString.append("\n")
            }
        }
        
        gridStringArray = []
        matrixString = inputString
        inputString = ""
        return matrixString
    }
    
    func gcd(_ a: Int, _ b: Int) -> Int {
        if b == 0 {
            return a
        }
        else {
            return gcd(b, a % b)
        }
    }
    
    func getNum9(_ len: Int) -> Int {
        
        var res: Int = 1
        
        if len == 0 {
            return 0
        }
        
        for _ in 0..<len {
            res *= 10
        }
        
        return res - 1
    }
    
    func getNum(_ s: Int, _ t: Int, _ str: [String]) -> Int {
        
        var res: Int = 0
        
        for i in s..<t {
            res = res * 10 + Int(Double(str[i])!)
        }
        
        return res
    }
    
    func decimalOrFraction(_ input: String) -> String {
        
        var rows: Int = 1
        var columns: Int
        var inputString: String = ""
        var decimal: [String]
        
        numberFormatter.maximumFractionDigits = 5
        
        if dfCheck {
            
            for i in input {
                
                if i == "\n" {
                    rows += 1
                }
            }
            
            for i in input {
                if figureArray.contains(i) {
                    storageString.append(i)
                    check = true
                }
                else if check {
                    storageString.append(" ")
                    check = false
                }
            }
            
            gridStringArray = storageString.components(separatedBy: " ")
            columns = gridStringArray.count / rows
            gridStringArray = decimalToFraction2(&gridStringArray)
            
            var i = 0
            
            for a in 1...rows {
                for _ in 1..<columns {
                    inputString.append(gridStringArray[i])
                    inputString.append("   ")
                    i += 1
                }
                inputString.append(gridStringArray[i])
                i += 1
                if a != rows {
                    inputString.append("\n")
                }
            }
            
            storageString = ""
            gridStringArray = []
            dfCheck = false
            return inputString
        }
        else {
            
            for i in input {
                
                if i == "\n" {
                    rows += 1
                }
            }
            
            for i in input {
                if figureArray.contains(i) {
                    storageString.append(i)
                    check = true
                }
                else if check {
                    storageString.append(" ")
                    check = false
                }
            }
            
            gridStringArray = storageString.components(separatedBy: " ")
            columns = gridStringArray.count / rows
            
            for i in 0..<gridStringArray.count {
                
                if gridStringArray[i].contains("/") {
                    decimal = gridStringArray[i].components(separatedBy: "/")
                    if String(Double(decimal[0])! / Double(decimal[1])!).count <= 15 {
                        gridStringArray[i] = String(Double(decimal[0])! / Double(decimal[1])!)
                    }
                }
            }
            
            var i = 0
            
            for a in 1...rows {
                for _ in 1..<columns {
                    inputString.append(gridStringArray[i])
                    inputString.append("   ")
                    i += 1
                }
                inputString.append(gridStringArray[i])
                i += 1
                if a != rows {
                    inputString.append("\n")
                }
            }
            
            storageString = ""
            gridStringArray = []
            dfCheck = true
            return inputString
        }
    }
    
    func decimalOrFractionLE(_ input: String) -> String {
        
        var up: Double
        var down: Int = 1
        var Gcd: Int
        var inputString: String = ""
        var decimal: [String]
        var i1: Character = "x"
        var gridToString: [String] = []
        var exchange: String
        var countOfZero: Int
        var gridString: String = ""
        
        if dfCheck {
            
            for i in input {
                
                if (figureArray.contains(i) || i == "e") && i1 != "x" {
                    storageString.append(i)
                }
                
                if i == "\n" {
                    storageString.append(" ")
                }
                
                i1 = i
            }
            
            gridStringArray = storageString.components(separatedBy: " ")
            var numberToString: String
            var twoParts: [String]
            
            for i in 0..<gridStringArray.count {
                
                if gridStringArray[i].contains(".") && !gridStringArray[i].contains("/") {
                    
                    for a in gridStringArray[i] {
                        gridToString.append(String(a))
                    }
                    
                    if gridToString.contains("e") {
                        if gridToString[0] != "-" {
                            exchange = gridToString[0]
                            gridToString[0] = gridToString[1]
                            gridToString[1] = exchange
                            
                            countOfZero = 10 * Int(Double(gridToString[gridToString.count - 2])!) + Int(Double(gridToString[gridToString.count - 1])!)
                            
                            for _ in 1..<countOfZero {
                                gridToString.insert("0", at: 1)
                            }
                            
                            gridToString.insert("0", at: 0)
                            
                            for _ in 1...4 {
                                gridToString.remove(at: gridToString.count - 1)
                            }
                        }
                        else {
                            exchange = gridToString[1]
                            gridToString[1] = gridToString[2]
                            gridToString[2] = exchange
                            
                            countOfZero = 10 * Int(Double(gridToString[gridToString.count - 2])!) + Int(Double(gridToString[gridToString.count - 1])!)
                            
                            for _ in 1..<countOfZero {
                                gridToString.insert("0", at: 2)
                            }
                            
                            gridToString.insert("0", at: 1)
                            
                            for _ in 1...4 {
                                gridToString.remove(at: gridToString.count - 1)
                            }
                        }
                    }
                    
                    while gridToString.count > 12 {
                        gridToString.remove(at: gridToString.count - 1)
                    }
                    
                    for a in 0..<gridToString.count {
                        gridString.append(gridToString[a])
                    }
                    
                    gridStringArray[i] = gridString
                    gridToString = []
                    gridString = ""
                    
                    up = Double(gridStringArray[i])!
                    numberToString = String(up)
                    
                    var loop = 0
                    
                    while loop < 7 {
                        twoParts = numberToString.components(separatedBy: ".")
                        if twoParts[1] == "0" {
                            break
                        }
                        else {
                            up *= 10
                            down *= 10
                            numberToString = String(up)
                        }
                        loop += 1
                    }
                    
                    numberToString.remove(at: numberToString.index(before: numberToString.endIndex))
                    numberToString.remove(at: numberToString.index(before: numberToString.endIndex))
                    
                    Gcd = gcd(Int(Double(numberToString)!), down)
                    
                    up /= Double(abs(Gcd))
                    down /= abs(Gcd)
                    
                    numberToString = String(up)
                    numberToString.remove(at: numberToString.index(before: numberToString.endIndex))
                    numberToString.remove(at: numberToString.index(before: numberToString.endIndex))
                    
                    if down == 1 {
                        gridStringArray[i] = "\(Int(Double(numberToString)!)).0"
                    }
                    else {
                        gridStringArray[i] = "\(Int(Double(numberToString)!))/\(down)"
                    }
                    
                    down = 1
                }
            }
            
            for i in 1...gridStringArray.count {
                inputString.append("x\(i) = \(gridStringArray[i - 1])\n")
            }
            inputString.remove(at: inputString.index(before: inputString.endIndex))
            gridStringArray = []
            storageString = ""
            dfCheck = false
            return inputString
        }
        else {
            
            for i in input {
                
                if figureArray.contains(i) && i1 != "x" {
                    storageString.append(i)
                }
                
                if i == "\n" {
                    storageString.append(" ")
                }
                
                i1 = i
            }
            
            gridStringArray = storageString.components(separatedBy: " ")
            
            for i in 0..<gridStringArray.count {
                
                if gridStringArray[i].contains("/") {
                    decimal = gridStringArray[i].components(separatedBy: "/")
                    if String(Double(decimal[0])! / Double(decimal[1])!).count <= 15 {
                        gridStringArray[i] = String(Double(decimal[0])! / Double(decimal[1])!)
                    }
                }
            }
            
            for i in 1...gridStringArray.count {
                inputString.append("x\(i) = \(gridStringArray[i - 1])\n")
            }
            inputString.remove(at: inputString.index(before: inputString.endIndex))
            gridStringArray = []
            storageString = ""
            dfCheck = true
            return inputString
        }
    }
    
    func decimalOrFractionForDetOrTrace(_ input: String, _ detOrRank: Int) -> String {
        
        var up: Double
        var down: Int = 1
        var Gcd: Int
        var inputString: String = ""
        var decimal: [String]
        var gridToString: [String] = []
        var exchange: String
        var countOfZero: Int
        var gridString: String = ""
        
        if dfCheck2 {
            
            for i in input {
                
                if figureArray.contains(i) {
                    storageString.append(i)
                }
            }
            
            var numberToString: String
            var twoParts: [String]
            
            if storageString.contains(".") && !storageString.contains("/") {
                
                for a in storageString {
                    gridToString.append(String(a))
                }
                
                if gridToString.contains("e") {
                    if gridToString[0] != "-" {
                        exchange = gridToString[0]
                        gridToString[0] = gridToString[1]
                        gridToString[1] = exchange
                        
                        countOfZero = 10 * Int(Double(gridToString[gridToString.count - 2])!) + Int(Double(gridToString[gridToString.count - 1])!)
                        
                        for _ in 1..<countOfZero {
                            gridToString.insert("0", at: 1)
                        }
                        
                        gridToString.insert("0", at: 0)
                        
                        for _ in 1...4 {
                            gridToString.remove(at: gridToString.count - 1)
                        }
                    }
                    else {
                        exchange = gridToString[1]
                        gridToString[1] = gridToString[2]
                        gridToString[2] = exchange
                        
                        countOfZero = 10 * Int(Double(gridToString[gridToString.count - 2])!) + Int(Double(gridToString[gridToString.count - 1])!)
                        
                        for _ in 1..<countOfZero {
                            gridToString.insert("0", at: 2)
                        }
                        
                        gridToString.insert("0", at: 1)
                        
                        for _ in 1...4 {
                            gridToString.remove(at: gridToString.count - 1)
                        }
                    }
                }
                
                while gridToString.count > 12 {
                    gridToString.remove(at: gridToString.count - 1)
                }
                
                for a in 0..<gridToString.count {
                    gridString.append(gridToString[a])
                }
                
                storageString = gridString
                gridToString = []
                gridString = ""
                
                up = Double(storageString)!
                numberToString = String(up)
                
                var loop = 0
                
                while loop < 7 {
                    twoParts = numberToString.components(separatedBy: ".")
                    if twoParts[1] == "0" {
                        break
                    }
                    else {
                        up *= 10
                        down *= 10
                        numberToString = String(up)
                    }
                    loop += 1
                }
                
                numberToString.remove(at: numberToString.index(before: numberToString.endIndex))
                numberToString.remove(at: numberToString.index(before: numberToString.endIndex))
                
                Gcd = gcd(Int(Double(numberToString)!), down)
                
                up /= Double(abs(Gcd))
                down /= abs(Gcd)
                
                numberToString = String(up)
                numberToString.remove(at: numberToString.index(before: numberToString.endIndex))
                numberToString.remove(at: numberToString.index(before: numberToString.endIndex))
                
                if down == 1 {
                    storageString = "\(Int(Double(numberToString)!)).0"
                }
                else {
                    storageString = "\(Int(Double(numberToString)!))/\(down)"
                }
                
                down = 1
            }
            
            if detOrRank == 1 {
                inputString = "det(A) = \(storageString)"
            }
            else {
                inputString = "tr(A) = \(storageString)"
            }
            
            storageString = ""
            dfCheck2 = false
            return inputString
        }
        else {
            
            for i in input {
                
                if figureArray.contains(i) {
                    storageString.append(i)
                }
            }
            
            if storageString.contains("/") {
                decimal = storageString.components(separatedBy: "/")
                if String(Double(decimal[0])! / Double(decimal[1])!).count <= 15 {
                    storageString = String(Double(decimal[0])! / Double(decimal[1])!)
                }
            }
            
            if detOrRank == 1 {
                inputString = "det(A) = \(storageString)"
            }
            else {
                inputString = "tr(A) = \(storageString)"
            }
            
            storageString = ""
            dfCheck2 = true
            return inputString
        }
    }
    
    func adjointMatrix() -> String {
        
        var inputString = ""
        var result: [String] = []
        var adjoint = A.adjointMatrix()
        
        processError(&adjoint.grid)
        gridStringArray = decimalToFraction(adjoint.grid)
        
        for i in 0..<gridStringArray.count {
            result.append(gridStringArray[i])
        }
        
        gridStringArray = []
        
        for a in 0..<A.rows {
            for b in 0..<A.columns - 1 {
                inputString.append(result[a * A.columns + b])
                inputString.append("   ")
            }
            inputString.append(result[a * A.columns + A.columns - 1])
            if a != A.rows - 1 {
                inputString.append("\n")
            }
        }
        
        return inputString
    }
    
    func minimalPolynomial() -> String {
        return (A.minimalPolynomial())
    }
    
    /*func eigenValue() -> String {     单独求特征值可用本方法
        
        var result = A.eigenValue()
        var twoParts: [String]
        var resultToString = ""
        var resultDecimalToString = ""
        var resultString = "特征值为："
        
        for i in 0..<result.count {
            resultToString = String(result[i])
            twoParts = resultToString.components(separatedBy: ".")
            resultDecimalToString = twoParts[1]
            
            while resultDecimalToString.count > 2 {
                resultDecimalToString.remove(at: resultDecimalToString.index(before: resultDecimalToString.endIndex))
            }
            
            twoParts[1] = resultDecimalToString
            resultDecimalToString = twoParts[0]
            resultDecimalToString.append(".")
            resultDecimalToString.append(twoParts[1])
            result[i] = Double(resultDecimalToString)!
        }
        
        for i in 0..<result.count {
            if i != result.count - 1 {
                resultString.append("\(result[i]), ")
            }
            else {
                resultString.append("\(result[i])")
            }
        }
        
        return resultString
    }*/
    
    func eigenValueAndVector() -> String {
        
        var oneDimensionalArray: [String] = []
        var twoDimensionalArray: [[String]] = []
        var eigenVectorArray: [[[Double]]]
        var eigenVectorStringArray: [[[String]]] = []
        var eigenValueArray: [Double]
        var outputString = ""
        
        (eigenVectorArray, eigenValueArray) = A.eigenValueAndVector()
        
        if eigenValueArray == [0] {
            return "本App只能为特征值均为实数的矩阵求特征值和特征向量哦～！"
        }
        
        for a in 0..<eigenVectorArray.count {
            for b in 0..<eigenVectorArray[a].count {
                for c in 0..<eigenVectorArray[a][b].count {
                    oneDimensionalArray.append(String(eigenVectorArray[a][b][c]))
                }
                twoDimensionalArray.append(oneDimensionalArray)
                oneDimensionalArray = []
            }
            eigenVectorStringArray.append(twoDimensionalArray)
            twoDimensionalArray = []
        }
        
        for a in 0..<eigenVectorArray.count {
            for b in 0..<eigenVectorArray[a].count {
 
                processError(&eigenVectorArray[a][b])
                gridStringArray = decimalToFraction(eigenVectorArray[a][b])
                gridStringArray = decimalToFraction2(&gridStringArray)
                
                for j in 0..<gridStringArray.count {
                    eigenVectorStringArray[a][b][j] = gridStringArray[j]
                }
                
                gridStringArray = []
            }
        }
        
        for i in 1...eigenVectorArray.count {
            for j in 1...eigenVectorArray[i - 1].count {
                
                var loop = 0
                
                for g in 1...eigenVectorArray[i - 1][j - 1].count {
                    if eigenVectorArray[i - 1][j - 1][g - 1] == 0 {
                        loop += 1
                    }
                    else {
                        break
                    }
                }
                
                if loop == eigenVectorArray[i - 1][j - 1].count {
                    outputString.append("0.0")
                }
                
                for k in 1...eigenVectorArray[i - 1][j - 1].count {
                    
                    if eigenVectorArray[i - 1][j - 1][k - 1] != 0 {
                        
                        if outputString != "" {
                            if outputString.last! != " " && outputString.last! != "(" {
                                if eigenVectorArray[i - 1][j - 1][k - 1] > 0 {
                                    if eigenVectorArray[i - 1][j - 1][k - 1] == 1 {
                                        outputString.append("+α\(k)")
                                    }
                                    else {
                                        outputString.append("+\(eigenVectorStringArray[i - 1][j - 1][k - 1])α\(k)")
                                    }
                                }
                                else {
                                    if eigenVectorArray[i - 1][j - 1][k - 1] == -1 {
                                        outputString.append("-α\(k)")
                                    }
                                    else {
                                        outputString.append("\(eigenVectorStringArray[i - 1][j - 1][k - 1])α\(k)")
                                    }
                                }
                            }
                            else {
                                if eigenVectorArray[i - 1][j - 1][k - 1] == 1 {
                                    outputString.append("α\(k)")
                                }
                                else if eigenVectorArray[i - 1][j - 1][k - 1] == -1 {
                                    outputString.append("-α\(k)")
                                }
                                else {
                                    outputString.append("\(eigenVectorStringArray[i - 1][j - 1][k - 1])α\(k)")
                                }
                            }
                        }
                        else {
                            if eigenVectorArray[i - 1][j - 1][k - 1] == 1 {
                                outputString.append("α\(k)")
                            }
                            else if eigenVectorArray[i - 1][j - 1][k - 1] == -1 {
                                outputString.append("-α\(k)")
                            }
                            else {
                                outputString.append("\(eigenVectorStringArray[i - 1][j - 1][k - 1])α\(k)")
                            }
                        }
                    }
                }
                
                if j != eigenVectorArray[i - 1].count {
                    outputString.append("  ")
                }
            }
            
            if i == 1 {
                outputString.insert("(", at: outputString.startIndex)
            }
            
            outputString.append(")ᵀ, \(eigenValueArray[i - 1])\n")
            
            if i == eigenVectorArray.count {
                outputString.remove(at: outputString.index(before: outputString.endIndex))
            }
            
            if outputString != "" && i != eigenVectorArray.count {
                outputString.append("(")
            }
            
        }
        
        return outputString
    }
    
    func Jordan() -> String {
        
        let zeroMatrix = Matrix.init(rows: 1, columns: 1, repeatedValue: 0)
        let jordan = A.Jordan()
        if jordan.grid == zeroMatrix.grid {
            return "本App只能为特征值均为整数的矩阵求Jordan标准型哦～！"
        }
        else {
            return matrixToString(jordan)
        }
    }
    
    func Hessenberg() -> String {
        return matrixToString(A.Hessenberg())
    }
    
    func QRdecomposition() -> [String] {
        var Q: Matrix
        var R: Matrix
        (Q, R) = A.QRdecomposition()
        var matrixStringArray: [String] = []
        matrixStringArray.append(matrixToString(Q))
        matrixStringArray.append(matrixToString(R))
        return matrixStringArray
    }
    
    func export(_ matrix: String, _ rows: Int, _ columns: Int) -> String {
        let stringA = "%matrix begin\n$$\n\\left(\n\\begin{matrix}\n"
        let stringB = "\\end{matrix}\n\\right)\n$$\n%matrix end"
        
        createMatrixA(matrix, rows, columns)
        
        var latexString = stringA
        var stringArray = decimalToFraction(A.grid)
        
        stringArray = decimalToFraction2(&stringArray)
        
        for i in 1...rows {
            for j in 1...columns {
                latexString.append(stringArray[(i - 1) * columns + j - 1])
                latexString.append(" ")
                latexString.append("&")
                latexString.append(" ")
            }
            latexString.remove(at: latexString.index(before: latexString.endIndex))
            latexString.remove(at: latexString.index(before: latexString.endIndex))
            latexString.append("\\\\\n")
        }
        latexString.remove(at: latexString.index(before: latexString.endIndex))
        latexString.remove(at: latexString.index(before: latexString.endIndex))
        latexString.remove(at: latexString.index(before: latexString.endIndex))
        latexString.append("\n")
        
        latexString.append(stringB)
        
        return latexString
    }
    
    func processError(_ array: inout [Double]) {
        
        for i in 0..<array.count {
            if fabs(array[i]) - fabs(Double(Int(array[i]))) < 0.0001 || fabs(array[i]) - (fabs(Double(Int(array[i]))) + 1) < 0.0001 || fabs(array[i]) - (fabs(Double(Int(array[i]))) - 1) < 0.0001 {
                if fabs(array[i]) - fabs(Double(Int(array[i]))) < 0.0001 && fabs(array[i]) - fabs(Double(Int(array[i]))) > -0.0001 {
                    array[i] = Double(Int(array[i]))
                }
                else if fabs(array[i]) - (fabs(Double(Int(array[i]))) + 1) < 0.0001 && fabs(array[i]) - (fabs(Double(Int(array[i]))) + 1) > -0.0001 {
                    if array[i] < 0 {
                        array[i] = Double(Int(array[i])) - 1
                    }
                    else {
                        array[i] = Double(Int(array[i])) + 1
                    }
                }
                else if fabs(array[i]) - (fabs(Double(Int(array[i]))) - 1) < 0.0001 && fabs(array[i]) - (fabs(Double(Int(array[i]))) - 1) > -0.0001 {
                    array[i] = Double(Int(array[i])) + 1
                }
            }
        }
    }
    
    func decimalToFraction(_ x: [Double]) -> [String] {
        
        var integer: Int
        var decimal: Double
        var decimalString: String
        var decimalArray: [String] = []
        var exchange: String
        var up: Int = 0
        var down: Int = 0
        var d: Int
        var n1: Int
        var n9: Int
        var tmp_up: Int
        var tmp_down: Int
        var s = 2
        var t: Int
        var countOfZero: Int
        var stringArray: [String] = []
        
        for i in 0..<x.count {
            stringArray.append(String(x[i]))
        }
        
        var gridToString: String
        
        for i in 0..<stringArray.count {
            if Double(stringArray[i]) != Double(Int(Double(stringArray[i])!)) {
                gridToString = stringArray[i]
                while 1 == 1 {
                    gridToString.remove(at: gridToString.index(before: gridToString.endIndex))
                    if gridToString.contains(".") {
                        continue
                    }
                    else {
                        break
                    }
                }
                
                integer = Int(gridToString)!
                decimal = Double(stringArray[i])! - Double(integer)
                
                decimalString = String(decimal)
                
                while decimalString.count > 13 {
                    decimalString.remove(at: decimalString.index(before: decimalString.endIndex))
                }
                
                while decimalString.last! == "0" {
                    decimalString.remove(at: decimalString.index(before: decimalString.endIndex))
                }
                
                for j in decimalString {
                    decimalArray.append(String(j))
                }
                
                if decimalArray.contains("e") {
                    if decimalArray[0] != "-" {
                        exchange = decimalArray[0]
                        decimalArray[0] = decimalArray[1]
                        decimalArray[1] = exchange
                        
                        countOfZero = 10 * Int(Double(decimalArray[decimalArray.count - 2])!) + Int(Double(decimalArray[decimalArray.count - 1])!)
                        
                        for _ in 1..<countOfZero {
                            decimalArray.insert("0", at: 1)
                        }
                        
                        decimalArray.insert("0", at: 0)
                        
                        for _ in 1...4 {
                            decimalArray.remove(at: decimalArray.count - 1)
                        }
                    }
                    else {
                        exchange = decimalArray[1]
                        decimalArray[1] = decimalArray[2]
                        decimalArray[2] = exchange
                        
                        countOfZero = 10 * Int(Double(decimalArray[decimalArray.count - 2])!) + Int(Double(decimalArray[decimalArray.count - 1])!)
                        
                        for _ in 1..<countOfZero {
                            decimalArray.insert("0", at: 2)
                        }
                        
                        decimalArray.insert("0", at: 1)
                        
                        for _ in 1...4 {
                            decimalArray.remove(at: decimalArray.count - 1)
                        }
                    }
                }
                
                while decimalArray.count > 13 {
                    decimalArray.remove(at: decimalArray.count - 1)
                }
                
                if decimalArray.count > 12 {
                    if decimalArray[0] != "-" {
                        s = 2
                        t = decimalArray.count - 3
                        up = getNum(s, t, decimalArray)
                        down = getNum9(t - s)
                        d = gcd(up, down)
                        up /= d
                        down /= d
                        
                        if up != 0 {
                            n1 = getNum(s, t, decimalArray)
                            n9 = getNum9(t - s)
                            
                            for a in s + 1..<t {
                                tmp_up = n1 - getNum(s, a, decimalArray)
                                tmp_down = n9 - getNum9(a - s)
                                d = gcd(tmp_down, tmp_up)
                                tmp_down /= d
                                tmp_up /= d
                                
                                if tmp_down < down {
                                    down = tmp_down
                                    up = tmp_up
                                }
                            }
                            up += integer * down
                            if down == 1 {
                                stringArray[i] = "\(up)"
                            }
                            else {
                                stringArray[i] = "\(up)/\(down)"
                            }
                        }
                    }
                    else {
                        s = 3
                        t = decimalArray.count - 4
                        up = getNum(s, t, decimalArray)
                        down = getNum9(t - s)
                        d = gcd(up, down)
                        up /= d
                        down /= d
                        
                        if up != 0 {
                            n1 = getNum(s, t, decimalArray)
                            n9 = getNum9(t - s)
                            
                            for a in s + 1..<t {
                                tmp_up = n1 - getNum(s, a, decimalArray)
                                tmp_down = n9 - getNum9(a - s)
                                d = gcd(tmp_down, tmp_up)
                                tmp_down /= d
                                tmp_up /= d
                                
                                if tmp_down < down {
                                    down = tmp_down
                                    up = tmp_up
                                }
                            }
                            up += -integer * down
                            if down == 1 {
                                stringArray[i] = "-\(up)"
                            }
                            else {
                                stringArray[i] = "-\(up)/\(down)"
                            }
                        }
                    }
                }
                if !stringArray[i].contains("/") {
                    stringArray[i] = String(Double(integer) + Double(decimalString)!)
                }
            }
            decimalArray = []
        }
        return stringArray
    }
    
    func decimalToFraction2(_ array: inout [String]) -> [String] {
        
        var exchange: String
        var down: Int = 0
        var countOfZero: Int
        var gridToString2: [String] = []
        var gridString = ""
        var numberToString: String
        var twoParts: [String]
        var up2: Double
        var Gcd: Int
        
        down = 1
        
        for i in 0..<array.count {
            if !array[i].contains("/") {
                for a in array[i] {
                    gridToString2.append(String(a))
                }
                
                if gridToString2.contains("e") {
                    if gridToString2[0] != "-" {
                        exchange = gridToString2[0]
                        gridToString2[0] = gridToString2[1]
                        gridToString2[1] = exchange
                        
                        countOfZero = 10 * Int(Double(gridToString2[gridToString2.count - 2])!) + Int(Double(gridToString2[gridToString2.count - 1])!)
                        
                        for _ in 1..<countOfZero {
                            gridToString2.insert("0", at: 1)
                        }
                        
                        gridToString2.insert("0", at: 0)
                        
                        for _ in 1...4 {
                            gridToString2.remove(at: gridToString2.count - 1)
                        }
                    }
                    else {
                        exchange = gridToString2[1]
                        gridToString2[1] = gridToString2[2]
                        gridToString2[2] = exchange
                        
                        countOfZero = 10 * Int(Double(gridToString2[gridToString2.count - 2])!) + Int(Double(gridToString2[gridToString2.count - 1])!)
                        
                        for _ in 1..<countOfZero {
                            gridToString2.insert("0", at: 2)
                        }
                        
                        gridToString2.insert("0", at: 1)
                        
                        for _ in 1...4 {
                            gridToString2.remove(at: gridToString2.count - 1)
                        }
                    }
                }
                
                while gridToString2.count > 12 {
                    gridToString2.remove(at: gridToString2.count - 1)
                }
                
                for a in 0..<gridToString2.count {
                    gridString.append(gridToString2[a])
                }
                
                array[i] = gridString
                gridToString2 = []
                gridString = ""
                
                up2 = Double(array[i])!
                numberToString = String(up2)
                
                var loop = 0
                
                while loop < 5 {
                    twoParts = numberToString.components(separatedBy: ".")
                    if twoParts[1] == "0" {
                        break
                    }
                    else {
                        up2 *= 10
                        down *= 10
                        numberToString = String(up2)
                    }
                    loop += 1
                }
                
                numberToString.remove(at: numberToString.index(before: numberToString.endIndex))
                numberToString.remove(at: numberToString.index(before: numberToString.endIndex))
                
                Gcd = gcd(Int(Double(numberToString)!), down)
                
                up2 /= Double(abs(Gcd))
                down /= abs(Gcd)
                
                numberToString = String(up2)
                numberToString.remove(at: numberToString.index(before: numberToString.endIndex))
                numberToString.remove(at: numberToString.index(before: numberToString.endIndex))
                
                if down == 1 {
                    array[i] = "\(Int(Double(numberToString)!)).0"
                }
                else {
                    array[i] = "\(Int(Double(numberToString)!))/\(down)"
                }
                
                down = 1
            }
        }
        
        return array
    }
}
