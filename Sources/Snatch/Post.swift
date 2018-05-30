import Promise
import SnatchBase
import Foundation

public extension Snatch.Post {
    /**
     Sends an no headers, JSON encoded out of parameters body, POST request.
     
     - parameter url: the url.
     - parameter parameters: an encodable object to be encoded as JSON and sent as a body of the request.
     
     - returns: Promise that fulfills with Snatch.Result object.
     */
    public subscript<Parameters: Encodable>(_ url: URL, _ parameters: Parameters) -> Promise<Result> {
        guard let father = father else {
            return SnatchError.spooks.promised
        }
        
        var request = generateRequest(outOf: url, nil)
        
        do {
            try apply(parameters: parameters, to: &request)
        } catch {
            return SnatchError.encoding(error).promised
        }
        
        return father.request(request)
    }
    
    /**
     Sends a POST request with the specified parameters and headers.
     
     - parameter url: the url.
     - parameter parameters: an encodable object to be encoded as JSON and sent as a body of the request.
     - parameter headers: http headers
     
     - returns: Promise that fulfills with Snatch.Result object.
     */
    public subscript<Parameters: Encodable>(_ url: URL, _ parameters: Parameters?, _ headers: [String: String]) -> Promise<Result> {
        guard let father = father else {
            return SnatchError.spooks.promised
        }
        
        var request = generateRequest(outOf: url, headers)
        
        do {
            try apply(parameters: parameters, to: &request)
        } catch {
            return SnatchError.encoding(error).promised
        }
        
        return father.request(request)
    }
}
