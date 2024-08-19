import Foundation

// MARK: - League Response

struct LeagueResponse: Decodable {
    /// The Identifier
    let idLeague: String
    /// The Name
    let strLeague: String
    /// The Alternate Name
    let strLeagueAlternate: String?
}
