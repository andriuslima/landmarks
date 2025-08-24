import SwiftUI

struct LandmarkList: View {
    @Environment(ModelData.self) var modelData
    @State private var showFavoriteOnly = false
    
    var filteredLandmarks: [Landmark] {
        modelData.landmarks.filter { landmark in showFavoriteOnly ? landmark.isFavorite : true }
    }
    
    var body: some View {
        NavigationSplitView {
            List() {
                Toggle(isOn: $showFavoriteOnly) {
                    Text("Show favorites only")
                }
                ForEach(filteredLandmarks) {
                    l in NavigationLink {
                        LandmarkDetail(landmark: l)
                    } label: {
                        LandmarkRow(landmark: l)
                    }
                }
            }
            .animation(.default, value: filteredLandmarks)
            .navigationTitle("Landmarks")
        } detail: {
            Text("Select a landmark to see more details.")
        }
    }
}

#Preview {
    LandmarkList()
        .environment(ModelData())
}
