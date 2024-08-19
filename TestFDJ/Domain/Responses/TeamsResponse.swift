import Foundation

// MARK: - Teams Response

struct TeamsResponse: Decodable {
    /// Array of Items
    let teams: [TeamResponse]
}
