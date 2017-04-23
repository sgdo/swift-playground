public class ImageView: UIImageView {
    private var dataTask: URLSessionDataTask?

    public func loadImage(url: URL) {
        dataTask?.cancel()
        dataTask = NetworkManager.shared.fetchImage(url: url) { result in
            switch result {
            case .left:
                return
            case .right(let image):
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
    }

    public func clearImage() {
        dataTask?.cancel()
        image = nil
    }
}
