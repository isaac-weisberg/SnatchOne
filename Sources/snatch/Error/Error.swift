/**
   Represents errors that occur not on transport layer, but inside the API.

   - spooks: things that don't make no sense. Usually is to be treated as internal error.
*/
enum SnatchError: Error {
    case spooks

    var localizedDescription: String {
        switch self {
        case .spooks:
            return "Internal error"
        }
    }
}