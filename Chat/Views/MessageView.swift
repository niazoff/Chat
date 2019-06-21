//
//  MessageView.swift
//  Chat
//
//  Created by Natanel Niazoff on 6/19/19.
//  Copyright © 2019 Natanel Niazoff. All rights reserved.
//

import SwiftUI

struct MessageView: View {
  var viewModel: MessageViewModel
  
  var body: some View {
    HStack {
        VStack(alignment: .leading) {
          Text(viewModel.text)
            .fontWeight(.semibold)
          Text(viewModel.usernameText)
            .font(.caption)
        }
      Spacer()
      Text(verbatim: viewModel.dateText)
        .color(.gray)
    }.padding([.top, .bottom])
  }
}

#if DEBUG
struct MessageView_Previews : PreviewProvider {
  static let viewModel = MessageViewModel(message: Message(text: "Hello World!"))
  
  static var previews: some View {
    MessageView(viewModel: viewModel)
  }
}
#endif
