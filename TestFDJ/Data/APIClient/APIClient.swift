import Combine
import ComposableArchitecture
import Foundation

// MARK: - NetworkServiceError

enum APIClientError: Error {
    
    case retrieveData
}

// MARK: - NetworkServiceProtocol

protocol APIClientProtocol {
    
    func fetchLeagues() async throws -> [LeagueModel]
    func fetchTeams(for league: String) async throws -> [TeamModel]
    func fetchTeamDetails(for team: String) async throws -> TeamDetailsModel
}

// MARK: - NetworkService

class APIClient: APIClientProtocol {
    
    // MARK: Properties
    
    var networkClient: URLSession
    
    // MARK: Initializer
    
    public init(networkClient: URLSession) {
        self.networkClient = networkClient
    }
    
    // MARK: Methods
    
    func fetchLeagues() async throws -> [LeagueModel] {
        let (data, _) = try await networkClient.data(from: URLService.makeURL(for: .listAllLeagues))
        let response = try JSONDecoder().decode(LeaguesResponse.self, from: data)
        let leagues: [LeagueModel] = response.leagues.map { .init(from: $0) }
        return leagues
    }
    
    func fetchTeams(for league: String) async throws -> [TeamModel] {
        let (data, _) = try await networkClient.data(from: URLService.makeURL(for: .searchAllTeams(league: league)))
        let response = try JSONDecoder().decode(TeamsResponse.self, from: data)
        let teams: [TeamModel] = response.teams.map { .init(from: $0) }
        return teams
    }
    
    func fetchTeamDetails(for team: String) async throws -> TeamDetailsModel {
        let (data, _) = try await networkClient.data(from: URLService.makeURL(for: .searchTeam(team: team)))
        let response = try JSONDecoder().decode(TeamsDetailsResponse.self, from: data)
        guard let details = response.teams.first else {
            throw APIClientError.retrieveData
        }
        let teamDetails: TeamDetailsModel = .init(from: details)
        return teamDetails
    }
}
