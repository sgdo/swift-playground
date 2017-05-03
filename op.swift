postfix operator *!

postfix func *!(operand: Int) -> Int {
    return fac(operand)
}

func fac(_ operand: Int) -> Int {
    guard operand > 0 else { return 1 }
    var result = 1
    for i in 2...operand {
        result *= i
    }
    return result
}

print(6*!)
