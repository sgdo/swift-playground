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

    func foldr1<B>(_ f: (A) -> (B) -> B, _ z: B) -> B {
        switch self {
        case .cons(let x, let xs):
            return f(x)(xs.foldr1(f, z))
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

    func map1<B>(_ f: (A) -> B) -> List<B> {
        return foldr({ (x, y) in .cons(f(x), y) }, .empty)
    }

    func map2<B>(_ f: @escaping (A) -> B) -> List<B> {
        return foldr1(compose(curry(fcons), f), .empty)
    }
}

func compose<A, B, C>(_ f: @escaping (A) -> B, _ g: @escaping (C) -> A) -> (C) -> B {
    return { x in
        return f(g(x))
    }
}

func curry<A, B, C>(_ f: @escaping (A, B) -> C) -> (A) -> (B) -> C {
    return { x in
        return { y in
            return f(x, y)
        }
    }
}

func fcons<A>(_ x: A, _ xs: List<A>) -> List<A> {
    return .cons(x, xs)
}
