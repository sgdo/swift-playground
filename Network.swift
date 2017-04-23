import Foundation

public class Network {
    public static let shared = Network()

    private init() {}

    @discardableResult
    public func fetchURL(
        _ url: URL,
        completion: @escaping (Either<String, (Data, HTTPURLResponse)>) -> Void
    ) -> URLSessionDataTask {

        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let e = error {
                completion(.left(e.localizedDescription))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.left("response not a HTTP response"))
                return
            }

            guard (200..<300).contains(httpResponse.statusCode) else {
                completion(.left("invalid status code"))
                return
            }

            guard let theData = data, let theResponse = response as? HTTPURLResponse else {
                completion(.left("no body"))
                return
            }

            completion(.right((theData, theResponse)))
        }
        dataTask.resume()
        return dataTask
    }

    private func rethrow<A, B>(result: Either<String, B>, completion: @escaping (Either<String, A>) -> Void) {
        completion(result.either({ x in .left(x) }, { _ in .left("error") }))
    }
}
