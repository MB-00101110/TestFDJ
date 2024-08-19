import ComposableArchitecture
import SwiftUI

@Reducer
struct TeamDetailsFeature {
    
    @ObservableState
    struct State: Equatable {
        var details: TeamDetailsModel?
    }
    
    enum Action {
        case showDetails(TeamDetailsModel)
    }
    
    @Dependency(\.dismiss) var dismiss
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .showDetails(let details):
                state.details = details
                return .none
            }
        }
    }    
}
