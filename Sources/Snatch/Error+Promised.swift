import Promise
import SnatchBase

public extension SnatchError {
    var promised: Promise<Result> {
        return Promise(error: self)
    }
}
