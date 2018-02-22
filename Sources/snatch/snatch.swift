import Foundation

public class Snatch {
    static let shared = Snatch()

    let session = URLSession.shared

    let get = Get()

    typealias DataTaskCallback = (Data?, URLResponse?, Error?) -> Void

    func task(with url: URL, _ handler: @escaping DataTaskCallback) -> URLSessionDataTask {
        return session.dataTask(with: url, completionHandler: handler)
    }

    func task(with request: URLRequest, _ handler: @escaping DataTaskCallback) -> URLSessionDataTask {
        return session.dataTask(with: request, completionHandler: handler)
    }

    func commonHandler(_ fulfill: @escaping (Result) -> (), _ reject: @escaping (Error) -> ()) -> DataTaskCallback {
        return { data, response, error in
            if let error = error {
                reject(error)
                return
            }
            guard let resp = response as? HTTPURLResponse else {
                reject(SnatchError.spooks)
                return
            }
            let packedReponse = Result(from: resp, data)
            fulfill(packedReponse)
        }
    }
}
