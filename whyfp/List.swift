enum List<A> {
    indirect case cons(A, List<A>)
    case empty

    func foldr<B>(_ f: (A, B) -> B, _ z: B) -> B {
        switch self {
        case .cons(let x, let xs):
            return f(x, xs.foldr(f, z))
        case .empty:
            return z
        }
    }

    func map<B>(_ f: (A) -> B) -> List<B> {
        switch self {
        case .cons(let x, let xs):
            return .cons(f(x), xs.map(f))
        case .empty:
            return .empty
        }
    }
}

// define `map` in terms of `foldr`

extension List {
    func map1<B>(_ f: (A) -> B) -> List<B> {
        return foldr({ (x, y) in .cons(f(x), y) }, .empty)
    }
}

// define `foldr` on curried function

func foldr<A, B>(_ f: (A) -> (B) -> B, _ z: B, _ xs: List<A>) -> B {
    switch xs {
    case .cons(let y, let ys):
        return f(y)(foldr(f, z, ys))
    case .empty:
        return z
    }
}

// define `map` in terms of above `foldr`

func map<A, B>(_ f: @escaping (A) -> B, _ xs: List<A>) -> List<B> {
    return foldr(curry(List.cons) • f, .empty, xs)
}

// function composition

precedencegroup FunctionComposition {}
infix operator • : FunctionComposition

func •<A, B, C>(f: @escaping (A) -> B, g: @escaping (C) -> A) -> (C) -> B {
    return { x in
        return f(g(x))
    }
}

// currying

func curry<A, B, C>(_ f: @escaping (A, B) -> C) -> (A) -> (B) -> C {
    return { x in
        return { y in
            return f(x, y)
        }
    }
}

// some functions on lists

func sum(_ xs: List<Int>) -> Int {
    return foldr(curry(+), 0, xs)
}

func count<A>(_ x: A) -> (Int) -> Int {
    return { y in
        return y + 1
    }
}

func length(_ xs: List<Int>) -> Int {
    return foldr(count, 0, xs)
}
