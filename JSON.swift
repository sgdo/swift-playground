public struct JSON {
    fileprivate let value: Any?

    fileprivate func convert<T>() -> T? {
        return value.flatMap { $0 as? T }
    }

    public init(jsonObject: Any?) {
        value = jsonObject
    }

    public var bool: Bool? { return convert() }
    public var int: Int? { return convert() }
    public var double: Double? { return convert() }
    public var string: String? { return convert() }

    public var array: [JSON]? {
        guard let array = value as? [Any] else { return nil }
        return array.map { JSON(jsonObject: $0) }
    }

    public var object: [String: JSON]? {
        guard let object = value as? [String: Any] else { return nil }
        var o = [String: JSON]()
        for (k, v) in object {
            o[k] = JSON(jsonObject: v)
        }
        return o
    }

    public subscript(index: Int) -> JSON {
        guard let array = value as? [Any],
            index < array.count else { return JSON(jsonObject: nil) }
        return JSON(jsonObject: array[index])
    }

    public subscript(key: String) -> JSON {
        guard let object = value as? [String: Any?],
            let v = object[key] else { return JSON(jsonObject: nil) }
        return JSON(jsonObject: v)
    }
}
