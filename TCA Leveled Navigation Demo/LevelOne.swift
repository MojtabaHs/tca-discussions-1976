import SwiftUI
import ComposableArchitecture

struct LevelOne: ReducerProtocol {
    struct State: Equatable {
        @PresentationState var levelTwo: LevelTwo.State?

        var title = "Level one"
    }

    enum Action: Equatable {
        case onAppear
        case levelTwoTapped

        case levelTwo(PresentationAction<LevelTwo.Action>)
    }

    var body: some ReducerProtocolOf<Self> {
        Reduce<State, Action> { state, action in
            switch action {
            case .onAppear:
                print("On appear level one")
                return .none

            case .levelTwoTapped:
                state.levelTwo = .init()
                return .none

            case .levelTwo:
                return .none
            }
        }
        .ifLet(\.$levelTwo, action: /Action.levelTwo) {
            LevelTwo()
        }
    }
}

struct LevelOneView: View {
    let store: StoreOf<LevelOne>

    struct State: Equatable {
        var title: String

        init(_ featureState: LevelOne.State) {
            self.title = featureState.title
        }
    }

    var body: some View {
        WithViewStore(store, observe: State.init) { viewStore in
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
