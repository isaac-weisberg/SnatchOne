import Promise
import SnatchBase
import Foundation

public extension Result {
    /**
        Creates a promise that will attepmt to interpret the data of result AKA the body of http request as `type` TargetType type. If the body is empty, WILL REJECT.

        - parameter type: the type of object to try decode from the body of the response.

        - returns: promise resolveing with TargetType.
    */
    public func json<TargetType: Decodable>(_ type: TargetType.Type) -> Promise<TargetType> {
        return Promise { fulfill, reject in
            let result: TargetType = try self.json(type)

            fulfill(result)
        }
    }
}
