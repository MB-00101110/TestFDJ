import ComposableArchitecture
import SwiftUI

struct TeamListView: View {
        
    private let layout: [GridItem] = [
        .init(.adaptive(minimum: 80, maximum: 120)),
        .init(.adaptive(minimum: 80, maximum: 120)),
        .init(.adaptive(minimum: 80, maximum: 120))
    ]
    
    @Bindable var store: StoreOf<TeamListFeature>
    
    var body: some View {
        NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
            ScrollView {
                LazyVGrid(columns: self.layout) {
                    ForEach(store.teams) { team in
                        NavigationLink(state: TeamDetailsFeature.State(details: store.selectedTeamDetails)) {
                            AsyncImage(url: team.badgeURL) { image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .onTapGesture { store.send(.selectedTeam(team)) }
                            } placeholder: { ProgressView() }
                        }
                    }
                }
            }
            .searchable(text: $store.searchQuery.sending(\.updateSearchQuery))
            .searchSuggestions({
                ForEach(store.searchResults, id: \.self) { league in
                    Text(league.name)
                        .foregroundStyle(.black)
                        .searchCompletion(league.name)
                        .onSubmit(of: .search) { store.send(.selectedLeague(league)) }
                }
            })
        } destination: { store in
            TeamDetailsView(store: store)
        }
        .onAppear { store.send(.onAppear) }
    }
}

#Preview {
    TeamListView(
        store: Store(
            initialState: TeamListFeature.State(), 
            reducer: { TeamListFeature() }
        )
    )
}
