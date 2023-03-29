import SwiftUI
import ComposableArchitecture

struct LevelTwo: ReducerProtocol {
    struct State: Equatable {
        @PresentationState var levelThree: LevelThree.State?

        var title = "Level two"
    }

    enum Action: Equatable {
        case onAppear
        case levelThreeTapped

        case levelThree(PresentationAction<LevelThree.Action>)
    }

    var body: some ReducerProtocolOf<Self> {
        Reduce<State, Action> { state, action in
            switch action {
            case .onAppear:
                print("On appear level two")
                return .none

            case .levelThreeTapped:
                state.levelThree = .init()
                return .none

            case .levelThree:
                return .none
            }
        }
        .ifLet(\.$levelThree, action: /Action.levelThree) {
            LevelThree()
        }
    }
}

struct LevelTwoView: View {
    let store: StoreOf<LevelTwo>

    struct State: Equatable {
        var title: String

        init(_ featureState: LevelTwo.State) {
            self.title = featureState.title
        }
    }

    var body: some View {
        WithViewStore(store, observe: State.init) { viewStore in
            NavigationLinkStore(
                store.scope(state: \.$levelThree, action: LevelTwo.Action.levelThree)) {
                    viewStore.send(.levelThreeTapped)
                } destination: { store in
                    LevelThreeView(store: store)
                } label: {
                    Text(viewStore.title)
                }
                .onAppear {
                    viewStore.send(.onAppear)
                }
        }
    }
}
