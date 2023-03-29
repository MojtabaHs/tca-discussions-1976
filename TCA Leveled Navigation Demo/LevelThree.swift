import SwiftUI
import ComposableArchitecture

struct LevelThree: ReducerProtocol {
    struct State: Equatable {
        var title = "Level three"
    }

    enum Action: Equatable {
        case onAppear
    }

    var body: some ReducerProtocolOf<Self> {
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

    struct State: Equatable {
        var title: String

        init(_ featureState: LevelThree.State) {
            self.title = featureState.title
        }
    }

    var body: some View {
        WithViewStore(store, observe: State.init) { viewStore in
            Text(viewStore.title)
                .onAppear {
                    viewStore.send(.onAppear)
                }
        }
    }
}
