import Foundation
import ReSwift
import MultipeerConnectivity

var Store = ReSwift.Store(
  reducer: AppState.reduce,
  state: AppState(),
  middleware: [
    Middleware.create(BrowserState.middleware()),
    Middleware.create(ChatState.middleware())
  ]
)

struct AppState: StateType {
  
  // MARK: - Properties
  
  var browser = BrowserState()
  
  var hostChat = Preferences.shared.chatHistory ?? ChatState(host: Preferences.shared.userProfile)
  var guestChat: ChatState?
  
    
  // MARK: - Reducer
  
  static func reduce(action: Action, state: AppState?) -> AppState {
    return AppState(
      browser: BrowserState.reduce(action: action, state: state?.browser),
      hostChat: ChatState.hostChatReduce(action: action, state: state?.hostChat),
      guestChat: ChatState.guestChatReduce(action: action, state: state?.guestChat))
  }
}


