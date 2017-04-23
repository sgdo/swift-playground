public enum Either<A, B>{
    case left(A)
    case right(B)

    public func either<C>(_ f: (A) -> C, _ g: (B) -> C) -> C {
        switch self {
        case .left(let a):
            return f(a)
        case .right(let b):
            return g(b)
        }
    }
}
