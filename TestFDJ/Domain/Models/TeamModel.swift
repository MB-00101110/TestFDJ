import Foundation

// MARK: - TeamModel

struct TeamModel {
        
    let idTeam: String
    let name: String
    let badgeURL: URL?
    
    // MARK: Initializer
    
    init(idTeam: String, name: String, badgeURL: URL?) {
        self.idTeam = idTeam
        self.name = name
        self.badgeURL = badgeURL
    }

    init(from response: TeamResponse) {
        self.init(
            idTeam: response.idTeam,
            name: response.strTeam,
            badgeURL: URL(string: response.strBadge ?? "")
        )
    }
}

// MARK: - Conformance to Equatable

extension TeamModel: Equatable { }

// MARK: - Conformance to Identifiable & Hashable

extension TeamModel: Identifiable, Hashable {
    var id: String { idTeam }
}
