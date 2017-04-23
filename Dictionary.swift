extension Dictionary {
    public func mapValue<A>(_ f: (Value) -> A) -> Dictionary<Key, A> {
        var d: Dictionary<Key, A> = [:]
        for (k, v) in self {
            d[k] = f(v)
        }
        return d
    }
}
