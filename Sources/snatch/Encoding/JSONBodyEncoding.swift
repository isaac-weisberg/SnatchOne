import Foundation

class JSONBodyEncoding {
    let encoder = JSONEncoder()

    func encode<Parameters: Encodable>(_ parameters: Parameters) throws -> Data {
         return try encoder.encode(parameters)
    }

    func apply<Parameters: Encodable>(_ parameters: Parameters, to request: inout URLRequest) throws {
        let data = try encode(parameters)

        request.httpBody = data
    }
}