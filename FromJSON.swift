public protocol FromJSON {
    static func importFromJSON(_ json: JSON) -> Self?
}
