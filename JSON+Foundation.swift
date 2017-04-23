import Foundation

public extension JSON {
    public init?(data: Data) {
        guard let object = try? JSONSerialization.jsonObject(with: data) else { return nil }
        self.init(jsonObject: object)
    }
}
