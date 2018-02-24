import Foundation
import Promise

public class Snatch {
    static let shared = Snatch()

    /**
        The underlying URLSession object.
    */
    let session: URLSession

    /**
        A reference to a Get module.
    */
    let get = Get()

    /**
        A handler type used for dataTask completion on URLSession.
    */
    typealias DataTaskCallback = (Data?, URLResponse?, Error?) -> Void

    init(with sessionConfig: URLSessionConfiguration = URLSessionConfiguration.default) {
        self.session = URLSession(configuration: sessionConfig)
        // Give a reference to a Snatch instance to all the extensions.
        get.father = self
    }

    /**
        Starts a data task on a shared URLSession, resolves upon completion.

        - parameter url: URL. Default headers, empty body, if you really want, put url encoded query there yourself.

        - returns: Promise that fulfills with Snatch.Result object.
    */
    func request(_ url: URL) -> Promise<Result> {
        return Promise { fulfill, reject in
            let handler = self.commonHandler(fulfill, reject)

            self.task(with: url, handler).resume()
        }
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

    /**
        Creates a data task out of an arbitrary url and DataTaskCallback

        - parameter url: a url to a remote resourse. URLEncoded query is users' concern.
        - parameter handler: completion handler for the data task

        - returns: URLSessionDataTask, the data task that needs to be resumed in order to be started.
    */
    func task(with url: URL, _ handler: @escaping DataTaskCallback) -> URLSessionDataTask {
        return session.dataTask(with: url, completionHandler: handler)
    }

    /**
        Creates a data task out of an arbitrary request object and DataTaskCallback

        - parameter request: URLRequest object
        - parameter handler: completion handler for the data task

        - returns: URLSessionDataTask, the data task that needs to be resumed in order to be started.
    */
    func task(with request: URLRequest, _ handler: @escaping DataTaskCallback) -> URLSessionDataTask {
        return session.dataTask(with: request, completionHandler: handler)
    }

    /**
        Returns a generalized handler that is to be used for conditional promise resolvation upon all the URLRequests finish.
        
        - parameter fulfill: fullfiller of a promise
        - parameter reject: rejector of a promise

        - returns: DataTaskCallback, i.e. a closure that is meant to be called by URLSessionDataTask upon completion :)
    */
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
