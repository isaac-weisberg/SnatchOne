import Promise
import Foundation

extension Result {
    class NoBodyError: Error {
        var localizedDescription: String = "The response body is empty."
    }

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