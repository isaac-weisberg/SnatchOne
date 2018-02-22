import Promise
import Foundation

/**
    This extension adds capability to perform get requests.
*/
extension Snatch {
    class Get: SnatchModule {
        weak var father: Snatch?

        /**
            Starts a data task on a shared URLSession, resolves upon completion.

            - parameter url: url of a remote endpoint, preferably with http/https protocol. Any URL encoded body that you would like to include with the request, you have to add **manually**.

            - returns: Promise that fulfills with Snatch.Result object.
        */
        subscript(_ url: URL) -> Promise<Result> {
            guard let father = self.father else {
                return Promise(error: SnatchError.spooks)
            }
            return father.request(url)
        }
    }
}