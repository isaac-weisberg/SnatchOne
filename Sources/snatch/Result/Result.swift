import Foundation

/**
    Exists to collate results of an HTTP request into a single entity.
*/
class Result {
    /**
        Raw body of the response.
    */
    let data: Data?

    /**
        URLSessions' response object.
    */
    let response: HTTPURLResponse

    init(from response: HTTPURLResponse, _ data: Data? = nil) {
        self.response = response
        self.data = data
    }
}