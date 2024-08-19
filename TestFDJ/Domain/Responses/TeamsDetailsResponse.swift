import Foundation

struct TeamsDetailsResponse: Decodable {
    /// Array of Items
    let teams: [TeamDetailsResponse]
}
