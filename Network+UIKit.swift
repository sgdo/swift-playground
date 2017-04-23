import UIKit

extension Network {
    public func fetchImage(
        url: URL,
        completion: @escaping (Either<String, UIImage>) -> Void
    ) -> URLSessionDataTask {

        return fetchURL(url) { result in
            switch result {
            case .left:
                self.rethrow(result: result, completion: completion)
            case .right((let data, _)):
                guard let image = UIImage(data: data) else {
                    completion(.left("received invalid image data"))
                    return
                }
                completion(.right(image))
            }
        }
    }
}
