import Promise
import Foundation

/**
    This extension adds capability to perform get requests.
*/
extension Snatch {
    /**
        Starts a data task on a shared URLSession, resolves upon completion.

        - parameter url: url of a remote endpoint, preferably with http/https protocol. Any URL encoded body that you would like to include with the request, you have to add **manually**.

        - returns: Promise that resolves with Snatch.Response object.
    */
    func get(_ url: URL) -> Promise<Response> {
        return Promise { resolve, reject in
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    reject(error)
                    return
                }
                guard let resp = response as? HTTPURLResponse else {
                    reject(SnatchError.spooks)
                    return
                }
                let packedReponse = Response(from: resp, data)
                resolve(packedReponse)
            }.resume()
        }
    }
}