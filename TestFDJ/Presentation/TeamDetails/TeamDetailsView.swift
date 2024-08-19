import ComposableArchitecture
import SwiftUI

struct TeamDetailsView: View {
        
    @Bindable var store: StoreOf<TeamDetailsFeature>

    var body: some View {
        Form {
            AsyncImage(url: store.details?.bannerURL) { image in
                image.resizable().aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }
            Spacer()
            Text(store.details?.country ?? "N/A")
            Spacer()
            Text(store.details?.descriptionFR ?? "N/A")
        }
        .navigationTitle(Text(store.details?.name ?? "N/A"))
    }
}

#Preview {
    NavigationStack {
        TeamDetailsView(
            store: Store(
                initialState: TeamDetailsFeature.State(
                    details: TeamDetailsModel(idTeam: "1", name: "Club", country: "France", descriptionFR: "Description", bannerURL: URL(string: "https://www.thesportsdb.com/images/media/team/badge/ix6q4w1678808069.png")!)
                )
            ) {
                TeamDetailsFeature()
            }
        )
    }
}
