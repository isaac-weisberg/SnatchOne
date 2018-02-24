import Promise
import Foundation

/**
    This extension adds capability to perform post requests.
*/
extension Snatch {
    class Post: SnatchModule {
        weak var father: Snatch?

        /**
            Sends an empty body, no headers POST request directly at URL.

            - parameter url: the url

            - returns: Promise that fulfills with Snatch.Result object.
        */
        subscript(_ url: URL) -> Promise<Result> {
            guard let father = father else {
                return SnatchError.spooks.promised
            }

            let request = generateRequest(outOf: url, nil)

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

        func apply(_ parameters: [String: Encodable], to request: inout URLRequest) throws {
            let encoder = JSONEncoder()

            let data = try encoder.encode(parameters)

            request.httpBody = data
        }
    }
}