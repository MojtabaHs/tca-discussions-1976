import SwiftUI
import ComposableArchitecture

struct LevelThree: Reducer {
    struct State: Equatable {
        var title = "Level three"
    }

    enum Action: Equatable {
        case onAppear
    }

    var body: some ReducerOf<Self> {
        Reduce<State, Action> { state, action in
            switch action {
            case .onAppear:
                print("On appear level three")
                return .none
            }
        }
    }
}

struct LevelThreeView: View {
    let store: StoreOf<LevelThree>

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            Text(viewStore.title)
                .onAppear {
                    viewStore.send(.onAppear)
                }
        }
    }
}
