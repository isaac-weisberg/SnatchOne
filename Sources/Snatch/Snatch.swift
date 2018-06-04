import SnatchBase
import Promise
import Foundation

public extension Snatch {
    /**
     Starts a data task on a shared URLSession, resolves upon completion.
     
     - parameter request: URLRequest. Use this object to configure methods, headers and all the things.
     
     - returns: Promise that fulfills with Snatch.Result object.
     */
    public func request(_ request: URLRequest) -> Promise<Result> {
        return Promise { fulfill, reject in
            let handler = self.commonHandler(fulfill, reject)
            
            self.task(with: request, handler).resume()
        }
    }
    
    /**
     Returns a generalized handler that is to be used for conditional promise resolvation upon all the URLRequests finish.
     
     - parameter fulfill: fullfiller of a promise
     - parameter reject: rejector of a promise
     
     - returns: DataTaskCallback, i.e. a closure that is meant to be called by URLSessionDataTask upon completion :)
     */
    internal func commonHandler(_ fulfill: @escaping (Result) -> (), _ reject: @escaping (Error) -> ()) -> SnatchTaskCallback {
        return { result in
            switch result {
            case .success(let res):
                fulfill(res)
            case .failure(let error):
                reject(error)
            }
        }
    }
}
