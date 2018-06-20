//import Promise
//import Snatch
//import Foundation

//public extension Snatch.Get {
    /**
     Starts a data task on a URLSession, resolves upon completion.
     
     - parameter url: url of a remote endpoint, preferably with http/https protocol. Any URL encoded body that you would like to include with the request, you have to add **manually**.
     
     - returns: Promise that fulfills with Snatch.Result object.
     */
//    public subscript(_ url: URL) -> Promise<Result> {
//        return self[ url, nil, nil ]
//    }
    
    /**
     Encodes parameters into the URL, overriding whatever query it was carrying and resolves upon completion of a request.
     
     - parameter url: url of a remote endpoint, preferably with http/https protocol.
     - parameter params: parameters that will be URL encoded into the request. They will be encoded specifically right into a query of a URL, not the body of the HTTP request.
     
     - returns: Promise that fulfills with Snatch.Result object.
     */
//    public subscript(_ url: URL, _ params: [AnyHashable: Any]) -> Promise<Result> {
//        return self [ url, params, nil ]
//    }
    
    /**
     Encodes parameters if present into url and performs a request using them HTTP headers
     
     - parameter url: url of a remote endpoint, preferably with http/https protocol.
     - parameter params: parameters that will be URL encoded into the request. They will be encoded specifically right into a query of a URL, not the body of the HTTP request.
     - parameter headers: headers dictionary to be used in the request.
     
     - returns: Promise that fulfills with Snatch.Result object.
     */
//    public subscript(_ url: URL, _ params: URLQueryEncoding.Parameters?, _ headers: [String: String]?) -> Promise<Result> {
//        let request: URLRequest
//
//        do {
//            request = try generate(url, params, headers)
//        } catch {
//            return Promise(error: error)
//        }
//
//        return father.request(request)
//    }
//}
