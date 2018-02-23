import Foundation

extension URL {
    var components: NSURLComponents? {
        return NSURLComponents(url: self, resolvingAgainstBaseURL: false)
    }
}