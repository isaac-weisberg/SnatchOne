import Promise
import Foundation

/**
    This extension adds capability to perform get requests.
*/
extension Snatch {
    class Get: SnatchModule {
        weak var father: Snatch?

        /**
            Starts a data task on a URLSession, resolves upon completion.

            - parameter url: url of a remote endpoint, preferably with http/https protocol. Any URL encoded body that you would like to include with the request, you have to add **manually**.

            - returns: Promise that fulfills with Snatch.Result object.
        */
        subscript(_ url: URL) -> Promise<Result> {
            guard let father = father else {
                return SnatchError.spooks.promised
            }

            // let encoder = URLQueryEncoding()

            // guard let urlWithUpdateQuery = encoder.swapQuery(of: url, with: parameters) else {
            //     throw SnatchError.spooks
            // }

            // newUrl = urlWithUpdateQuery

            let request = generateRequest(outOf: url)

            return father.request(request)
        }

        /*
            Encodes parameters into the URL, overriding whatever query it was carrying and resolves upon completion of a request.

            - parameter url: url of a remote endpoint, preferably with http/https protocol.
            - parameter params: parameters that will be URL encoded into the request. They will be encoded specifically right into a query of a URL, not the body of the HTTP request.

            - returns: Promise that fulfills with Snatch.Result object.
        */
        subscript(_ url: URL, _ params: [AnyHashable: Any]) -> Promise<Result> {
            // let encoder = URLQueryEncoding()

            // let query = encoder.encode(params)

            // guard let components = url.components else {
            //     return SnatchError.spooks.promised
            // }

            // components.query = query

            // guard let newURL = components.url else {
            //     return SnatchError.spooks.promised
            // }

            // guard let newURL = encoder.swapQuery(of: url, with: query) else {
            //     return SnatchError.spooks.promised
            // }

            // guard let newURL = encoder.swapQuery(of: url, with: params) else {
            //     return SnatchError.spooks.promised
            // }

            guard let newURL = try? swapQuery(of: url, with: params) else {
                return SnatchError.spooks.promised
            }

            return self [ newURL ]
        }

        /**
            Encodes parameters if present into url and performs a request using them HTTP headers

            - parameter url: url of a remote endpoint, preferably with http/https protocol.
            - parameter params: parameters that will be URL encoded into the request. They will be encoded specifically right into a query of a URL, not the body of the HTTP request.
            - parameter headers: headers dictionary to be used in the request.

            - returns: Promise that fulfills with Snatch.Result object.
        */
        subscript(_ url: URL, _ parameters: [AnyHashable: Any]?, _ headers: [String: String]) -> Promise<Result> {
            guard let father = father else {
                return SnatchError.spooks.promised
            }

            let newURL: URL
            if let parameters = parameters {
                guard let updatedURL = try? swapQuery(of: url, with: parameters) else {
                    return SnatchError.spooks.promised
                }

                newURL = updatedURL
            } else {
                newURL = url
            }

            let request = generateRequest(outOf: newURL, headers)

            return father.request(request)
        }

        func swapQuery(of url: URL, with parameters:[AnyHashable: Any]) throws -> URL {
            let encoder = URLQueryEncoding()

            guard let urlWithUpdateQuery = encoder.swapQuery(of: url, with: parameters) else {
                throw SnatchError.spooks
            }

            return urlWithUpdateQuery
        } 

        func generateRequest(outOf url: URL, _ headers: [String: String]? = nil) -> URLRequest {
            var request = URLRequest(url: url)

            request.httpMethod = "GET"
            request.allHTTPHeaderFields = headers

            return request
        }
    }
}