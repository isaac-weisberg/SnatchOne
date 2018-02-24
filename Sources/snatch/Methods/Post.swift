import Promise
import Foundation

/**
    This extension adds capability to perform post requests.
*/
extension Snatch {
    class Post: SnatchModule {
        weak var father: Snatch?
        
        subscript(_ url: URL) -> Promise<Result> {
            guard let father = father else {
                return SnatchError.spooks.promised
            }

            var request = URLRequest(url: url)

            request.httpMethod = "POST"

            return father.request(request)
        }
    }
}