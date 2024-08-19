import Foundation

// MARK: - TeamResponse

struct TeamDetailsResponse: Decodable {
    /// The Identifier
    let idTeam: String
    /// The Name
    let strTeam: String
    /// The Alternate Name
    let strAlternate: String?
    /// The Description in French
    let strDescriptionFR: String?
    /// The Country Name
    let strCountry: String?
    /// The League Name
    let strLeague: String?
    /// The Banner Image URL
    let strBanner: String?
}
