import Promise
import Snatch
import Foundation

public extension Snatch.Post {
    /**
     Sends an no headers, JSON encoded out of parameters body, POST request.
     
     - parameter url: the url.
     - parameter parameters: an encodable object to be encoded as JSON and sent as a body of the request.
     
     - returns: Promise that fulfills with Snatch.Result object.
     */
    public subscript<Parameters: Encodable>(_ url: URL, _ parameters: Parameters) -> Promise<Result> {
        return self [ url, parameters, nil ]
    }
    
    /**
     Sends a POST request with the specified parameters and headers.
     
     - parameter url: the url.
     - parameter parameters: an encodable object to be encoded as JSON and sent as a body of the request.
     - parameter headers: http headers
     
     - returns: Promise that fulfills with Snatch.Result object.
     */
    public subscript<Parameters: Encodable>(_ url: URL, _ parameters: Parameters?, _ headers: [String: String]?) -> Promise<Result> {
        let request: URLRequest
        do {
            request = try generate(url, parameters, headers)
        } catch {
            return Promise(error: error)
        }
        
        return father.request(request)
    }
}
