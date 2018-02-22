import Foundation
import Promise

public class Snatch {
    static let shared = Snatch()

    let session = URLSession.shared

    let get = Get()

    typealias DataTaskCallback = (Data?, URLResponse?, Error?) -> Void

    init() {
        get.father = self
    }

    /**
        Starts a data task on a shared URLSession, resolves upon completion.

        - parameter request: URLRequest. Use this object to configure methods, headers and all the things.

        - returns: Promise that fulfills with Snatch.Result object.
    */
    func request(_ request: URLRequest) -> Promise<Result> {
        return Promise { fulfill, reject in
            let handler = self.commonHandler(fulfill, reject)

            self.task(with: request, handler).resume()
        }
    }

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
