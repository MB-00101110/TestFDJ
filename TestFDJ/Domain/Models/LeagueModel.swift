import Foundation

// MARK: - LeagueModel

struct LeagueModel {
    
    let idLeague: String
    let name: String
    
    // MARK: Initializer
    
    init(from response: LeagueResponse) {
        self.idLeague = response.idLeague
        self.name = response.strLeague
    }
}

// MARK: - Conformance to Equatable

extension LeagueModel: Equatable { }

// MARK: - Conformance to Identifiable & Hashable

extension LeagueModel: Identifiable, Hashable {
    var id: String { idLeague }
}
