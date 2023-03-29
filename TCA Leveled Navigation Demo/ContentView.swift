import SwiftUI
import ComposableArchitecture

struct ContentView: View {
    let store: StoreOf<LevelOne>

    var body: some View {
        NavigationView {
            WithViewStore(store, observe: { $0 }) { viewStore in
                NavigationLinkStore(
                    store.scope(state: \.$levelTwo, action: LevelOne.Action.levelTwo)) {
                        viewStore.send(.levelTwoTapped)
                    } destination: { store in
                        LevelTwoView(store: store)
                    } label: {
                        Text(viewStore.title)
                    }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
