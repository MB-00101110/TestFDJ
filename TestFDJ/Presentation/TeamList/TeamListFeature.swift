import ComposableArchitecture
import SwiftUI

@Reducer
struct TeamListFeature {
    
    @ObservableState
    struct State: Equatable {
        
        @Presents var destination: Destination.State?
        var path = StackState<TeamDetailsFeature.State>()

        var isLoading: Bool = false
        var error: String?
        
        var searchQuery: String = ""
        var searchResults: [LeagueModel] {
            guard !searchQuery.isEmpty else { return leagues }
            return leagues
                .sorted { lhs, rhs -> Bool in
                    return lhs.name.localizedCaseInsensitiveCompare(rhs.name) == .orderedAscending
                }
                .filter { $0.name.lowercased().contains(searchQuery.lowercased()) }
        }
        var leagues: [LeagueModel] = []
        var selectedLeague: LeagueModel?
        var teams: [TeamModel] = []
        var selectedTeam: TeamModel?
        var selectedTeamDetails: TeamDetailsModel?
    }
    
    enum Action {
        case onAppear

        case fetchLeagues
        case fetchLeaguesResponse(TaskResult<[LeagueModel]>)
        
        case updateSearchQuery(String)
        case selectedLeague(LeagueModel)

        case fetchTeams(String)
        case fetchTeamsResponse(TaskResult<[TeamModel]>)

        case selectedTeam(TeamModel)

        case fetchTeamDetails(String)
        case fetchTeamDetailsResponse(TaskResult<TeamDetailsModel>)
                
        case destination(PresentationAction<Destination.Action>)
        case path(StackAction<TeamDetailsFeature.State, TeamDetailsFeature.Action>)
    }
    
    @Dependency(\.teamListEnvironment) var environment
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .send(.fetchLeagues)
                
            case .fetchLeagues:
                state.isLoading = true
                return .run { send in
                    do {
                        let leagues = try await environment.apiClient.fetchLeagues()
                        await send(.fetchLeaguesResponse(.success(leagues)))
                    } catch {
                        await send(.fetchLeaguesResponse(.failure(error)))
                    }
                }
                
            case .fetchLeaguesResponse(.success(let leagues)):
                state.leagues = leagues
                state.isLoading = false
                return .none
                
            case .fetchLeaguesResponse(.failure(let error)):
                state.error = error.localizedDescription
                state.isLoading = false
                return .none
                
            case .updateSearchQuery(let query):
                state.searchQuery = query
                return .none
                
            case .selectedLeague(let league):
                state.selectedLeague = league
                return .send(.fetchTeams(league.name))
                
            case .fetchTeams(let selectedLeague):
                state.isLoading = true
                return .run { send in
                    do {
                        let teams = try await environment.apiClient.fetchTeams(for: selectedLeague)
                        await send(.fetchTeamsResponse(.success(teams)))
                    } catch {
                        await send(.fetchTeamsResponse(.failure(error)))
                    }
                }
                
            case .fetchTeamsResponse(.success(let teams)):
                state.teams = teams
                state.isLoading = false
                return .none
                
            case .fetchTeamsResponse(.failure(let error)):
                state.error = error.localizedDescription
                state.isLoading = false
                return .none
                
            case .selectedTeam(let selectedTeam):
                state.selectedTeam = selectedTeam
                return .send(.fetchTeamDetails(selectedTeam.name))
                
            case .fetchTeamDetails(let team):
                state.isLoading = true
                return .run { send in
                    do {
                        let details = try await environment.apiClient.fetchTeamDetails(for: team)
                        await send(.fetchTeamDetailsResponse(.success(details)))
                    } catch {
                        await send(.fetchTeamDetailsResponse(.failure(error)))
                    }
                }
                
            case .fetchTeamDetailsResponse(.success(let teamDetails)):
                state.selectedTeamDetails = teamDetails
                state.destination = .teamDetails(TeamDetailsFeature.State(details: teamDetails))
                state.isLoading = false
                return .none
                
            case .fetchTeamDetailsResponse(.failure(let error)):
                state.error = error.localizedDescription
                state.isLoading = false
                return .none
                
            // -----
                
            case let .destination(.presented(.teamDetails(.showDetails(details)))):
                state.selectedTeamDetails = details
                return .none
                
            case .destination:
                return .none
                            
            case .path:
                return .none
            
            }
        }
        .ifLet(\.$destination, action: \.destination)
        .forEach(\.path, action: \.path) {
            TeamDetailsFeature()
        }
    }
}

extension TeamListFeature {
    
    @Reducer(state: .equatable)
    enum Destination {
        case teamDetails(TeamDetailsFeature)
    }
}

