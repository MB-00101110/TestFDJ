import Foundation

// MARK: - Leagues Response

struct LeaguesResponse: Decodable {
    /// Array of Items
    let leagues: [LeagueResponse]
}
