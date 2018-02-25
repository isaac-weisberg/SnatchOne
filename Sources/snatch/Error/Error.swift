/**
   Represents errors that occur not on transport layer, but inside the API.

   - spooks: things that don't make no sense. Usually is to be treated as internal error.
*/
enum SnatchError: Error {
    case spooks
    case encoding(Error)

    var localizedDescription: String {
        switch self {
        case .spooks:
            return "Internal error"
        case .encoding(let underlyingError):
            return "Encoding error: \(underlyingError)"
        }
    }
}