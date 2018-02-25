import Promise
import Foundation

/**
    This extension adds capability to perform post requests.
*/
extension Snatch {
    class Post: SnatchModule {
        weak var father: Snatch?

        /**
            Sends an empty body, no headers, POST request directly at URL.

            - parameter url: the url.

            - returns: Promise that fulfills with Snatch.Result object.
        */
        // subscript(_ url: URL) -> Promise<Result> {
        //     return self [ url, nil, nullableHeaders: nil ]
        // }

        /**
            Sends an no headers, JSON encoded out of parameters body, POST request.

            - parameter url: the url.
            - parameter parameters: an encodable object to be encoded as JSON and sent as a body of the request.

            - returns: Promise that fulfills with Snatch.Result object.
        */
        subscript<Parameters: Encodable>(_ url: URL, _ parameters: Parameters) -> Promise<Result> {
            return self [ url, parameters, nullableHeaders: nil ]
        }

        /**
            Sends a POST request with the specified parameters and headers.

            - parameter url: the url.
            - parameter parameters: an encodable object to be encoded as JSON and sent as a body of the request.
            - parameter headers: http headers

            - returns: Promise that fulfills with Snatch.Result object.
        */
        subscript<Parameters: Encodable>(_ url: URL, _ parameters: Parameters?, _ headers: [String: String]) -> Promise<Result> {
            return self [ url, parameters, headers ]
        }

        /**
            Sends a POST request with the specified parameters and headers.

            - parameter url: the url.
            - parameter parameters: an encodable object to be encoded as JSON and sent as a body of the request.
            - parameter headers: http headers

            - returns: Promise that fulfills with Snatch.Result object.
        */
        private subscript<Parameters: Encodable>(_ url: URL, _ parameters: Parameters?, nullableHeaders headers: [String: String]?) -> Promise<Result> {
            guard let father = father else {
                return SnatchError.spooks.promised
            }

            var request = generateRequest(outOf: url, headers)

            if let parameters = parameters {
                let encoder = JSONBodyEncoding()

                do {
                    try encoder.apply(parameters, to: &request)
                } catch {
                    return SnatchError.encoding(error).promised
                }
            }

            return father.request(request)
        }

        func generateRequest(outOf url: URL, _ headers: [String: String]? = nil) -> URLRequest {
            var request = URLRequest(url: url)

            request.httpMethod = "POST"

            if let headers = headers {
                request.allHTTPHeaderFields = headers
            }

            return request
        }
    }
}