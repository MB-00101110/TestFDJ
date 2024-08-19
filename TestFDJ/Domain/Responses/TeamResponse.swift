import Foundation

// MARK: - TeamResponse

struct TeamResponse: Decodable {
    /// The Identifier
    let idTeam: String
    /// The Name
    let strTeam: String
    /// The Alternate Name
    let strAlternate: String?
    /// The League Name
    let strLeague: String?
    /// The Badge Image URL
    let strBadge: String?
}
