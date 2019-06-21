//
//  MessageViewModel.swift
//  Chat
//
//  Created by Natanel Niazoff on 6/19/19.
//  Copyright © 2019 Natanel Niazoff. All rights reserved.
//

import Foundation
import Combine

final class MessageViewModel {
  private let calendar = Calendar.current
  private let message: Message
  
  var id: UUID { message.id }
  var text: String { message.text }
  var dateText: String { makeDateText(from: message.date) }
  var usernameText: String { message.username ?? Constants.defaultUsernameText }
  
  private struct Constants {
    static let todayDateTextFormat = "h:mm a"
    static let dateTextFormat = "M/d h:mm a"
    
    static let defaultUsernameText = "Anonymous"
  }
  
  init(message: Message) {
    self.message = message
  }
  
  private func makeDateText(from date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = calendar.isDateInToday(date) ? Constants.todayDateTextFormat : Constants.dateTextFormat
    return formatter.string(from: date)
  }
}
