import ComposableArchitecture
import Foundation

struct TeamListEnvironment: DependencyKey {
    
    var apiClient: APIClientProtocol
    var mainQueue: AnySchedulerOf<DispatchQueue>
    
    static let liveValue = TeamListEnvironment(
        apiClient: APIClient(networkClient: URLSession.shared),
        mainQueue: .main
    )
}

extension DependencyValues {
    
    var teamListEnvironment: TeamListEnvironment {
        get { self[TeamListEnvironment.self] }
        set { self[TeamListEnvironment.self] = newValue }
    }
}
