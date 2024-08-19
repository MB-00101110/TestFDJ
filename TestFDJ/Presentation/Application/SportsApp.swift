import ComposableArchitecture
import SwiftUI

@main
struct SportsApp: App {
    
    static let store: Store = .init(
        initialState: TeamListFeature.State()) {
            TeamListFeature()
            ._printChanges()
    }
    
    var body: some Scene {
        WindowGroup {
            TeamListView(store: Self.store)
        }
    }
}
