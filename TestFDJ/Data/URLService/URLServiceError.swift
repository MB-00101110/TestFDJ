import Foundation

// MARK: URLService Errors

enum URLServiceError: String, Error {
    
    case invalidURL = "The URL must be valid."
    case textEncoding = "Cannot encode text."
}
