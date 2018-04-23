import Foundation

/**
    Exists to collate results of an HTTP request into a single entity.
*/
public class Result {
    /**
        Raw body of the response.
    */
    public let data: Data?

    /**
        URLSessions' response object.
    */
    public let response: HTTPURLResponse

    init(from response: HTTPURLResponse, _ data: Data? = nil) {
        self.response = response
        self.data = data
    }
}
