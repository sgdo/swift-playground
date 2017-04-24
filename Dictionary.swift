extension Dictionary {
    public func mapValue<A>(_ f: (Value) -> A) -> Dictionary<Key, A> {
        var d: Dictionary<Key, A> = [:]
        for (k, v) in self {
            d[k] = f(v)
        }
        return d
    }

    /**
     * Right-biased union
     */
    public func union(_ dict: Dictionary<Key, Value>) -> Dictionary<Key, Value> {
        var d = self
        for (k, v) in dict {
            d[k] = v
        }
        return d
    }
}
