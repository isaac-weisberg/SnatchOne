import Promise
import Foundation

extension Result {
    /**
        This error gets thrown in rejection to an attempt to extract json from a result with empty body data.
    */
    class NoBodyError: Error {
        var localizedDescription: String = "The response body is empty."
    }

    /**
        Creates a promise that will attepmt to interpret the data of result AKA the body of http request as `type` TargetType type. If the body is empty, WILL REJECT.

        - parameter type: the type of object to try decode from the body of the response.

        - returns: promise resolveing with TargetType.
    */
    func json<TargetType: Decodable>(_ type: TargetType.Type) -> Promise<TargetType> {
        guard let data = data else {
            return Promise(error: NoBodyError())
        }

        return Promise { fulfill, reject in
            let decoder = JSONDecoder()

            let result = try decoder.decode(type, from: data)

            fulfill(result)
        }
    }
}