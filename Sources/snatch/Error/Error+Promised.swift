import Promise

extension SnatchError {
    var promised: Promise<Result> {
        return Promise(error: self)
    }
}