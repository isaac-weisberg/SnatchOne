import Foundation

class JSONBodyEncoding {
    let encoder = JSONEncoder()

    func encode(_ parameters: [String: Encodable]) throws -> Data {
         return try encoder.encode(parameters)
    }

    func apply(_ parameters: [String: Encodable], to request: inout URLRequest) throws {
        let data = try encode(parameters)

        request.httpBody = data
    }
}