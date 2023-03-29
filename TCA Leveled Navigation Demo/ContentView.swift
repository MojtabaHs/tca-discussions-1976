import SwiftUI
import ComposableArchitecture

struct ContentView: View {
    var body: some View {
        NavigationView {
            LevelOneView(
                store: .init(initialState: .init(), reducer: LevelOne()))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
