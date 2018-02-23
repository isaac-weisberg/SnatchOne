import Foundation

class URLQueryEncoding {

    /**
        Expects all members to be escaped
    */
    func encode(_ dict: [AnyHashable: Any]) -> String {
        return dict.map { "\($0)=\($1)" }.joined(separator: "&")
    }
}