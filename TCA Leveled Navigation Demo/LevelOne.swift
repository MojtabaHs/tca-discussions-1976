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
