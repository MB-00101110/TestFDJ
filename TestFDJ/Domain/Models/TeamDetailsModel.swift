import Foundation

// MARK: - TeamModel

struct TeamDetailsModel {
        
    let idTeam: String
    let name: String
    let country: String
    let descriptionFR: String?
    let bannerURL: URL?
    
    // MARK: Initializer
    
    init(idTeam: String, name: String, country: String, descriptionFR: String?, bannerURL: URL?) {
        self.idTeam = idTeam
        self.name = name
        self.country = country
        self.descriptionFR = descriptionFR
        self.bannerURL = bannerURL
    }
    
    init(from response: TeamDetailsResponse) {
        self.init(
            idTeam: response.idTeam,
            name: response.strTeam,
            country: response.strCountry ?? "",
            descriptionFR: response.strDescriptionFR,
            bannerURL: URL(string: response.strBanner ?? "")
        )
    }
}

// MARK: - Conformance to Equatable

extension TeamDetailsModel: Equatable { }

// MARK: - Conformance to Identifiable & Hashable

extension TeamDetailsModel: Identifiable, Hashable {
    var id: String { idTeam }
}
