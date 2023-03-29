import SwiftUI
import ComposableArchitecture

struct LevelTwo: Reducer {
    struct State: Equatable {
        @PresentationState var levelThree: LevelThree.State?

        var title = "Level two"
    }

    enum Action: Equatable {
        case onAppear
        case levelThreeTapped

        case levelThree(PresentationAction<LevelThree.Action>)
    }

    var body: some ReducerOf<Self> {
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

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
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
