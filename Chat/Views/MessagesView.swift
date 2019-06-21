//
//  MessagesView.swift
//  Chat
//
//  Created by Natanel Niazoff on 6/18/19.
//  Copyright © 2019 Natanel Niazoff. All rights reserved.
//

import SwiftUI
import Combine

struct MessagesView: View {
  @ObjectBinding var viewModel: MessagesViewModel
  @State private var messageTextFieldText = String()
  
  var body: some View {
    NavigationView {
      VStack {
        HStack {
          TextField($messageTextFieldText, placeholder: Text(verbatim: Constants.messageTextFieldPlaceholderText))
          Button(action: sendMessage) { Text(verbatim: Constants.sendButtonText).bold() }
        }.padding()
        List(viewModel.messageViewModels) { MessageView(viewModel: $0) }
        TextField($viewModel.username, placeholder: Text(verbatim: Constants.usernameTextFieldPlaceholderText))
          .multilineTextAlignment(.center)
          .padding()
      }.navigationBarTitle(Text(verbatim: Constants.navigationBarTitleText))
    }
  }
  
  private struct Constants {
    static let navigationBarTitleText = "Chat"
    
    static let messageTextFieldPlaceholderText = "What's happening?"
    static let sendButtonText = "Send"
    
    static let usernameTextFieldPlaceholderText = "Add your username..."
  }
  
  private func sendMessage() {
    guard !messageTextFieldText.isEmpty else { return }
    viewModel.sendMessage(with: messageTextFieldText) { error in
      guard error == nil else { return }
      self.messageTextFieldText = String()
    }
  }
}

extension MessagesViewModel: BindableObject {}
extension MessageViewModel: Identifiable {}

#if DEBUG
struct MessagesView_Previews: PreviewProvider {
  static let viewModel = MessagesViewModel()
  
  static var previews: some View {
    MessagesView(viewModel: viewModel)
  }
}
#endif
