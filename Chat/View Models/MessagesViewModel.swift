//
//  MessagesViewModel.swift
//  Chat
//
//  Created by Natanel Niazoff on 6/19/19.
//  Copyright © 2019 Natanel Niazoff. All rights reserved.
//

import Foundation
import Combine

final class MessagesViewModel {
  private let session = URLSession.shared
  private let encoder = JSONEncoder()
  private let decoder = JSONDecoder()
  
  private let socketSessionID = UUID()
  private lazy var socketURL = URL(string: "ws://localhost:8080/sessions/\(socketSessionID)")
  private lazy var socketTask = session.webSocketTask(with: socketURL ?? preconditionFailure())
  
  let didChange = PassthroughSubject<MessagesViewModel, Never>()
  
  private var messages = [Message]() {
    didSet { messageViewModels = makeMessageViewModels(messages: messages) }
  }
  
  var messageViewModels = [MessageViewModel]() {
    didSet { didChange.send(self) }
  }
  
  var username = String()
  
  init() {
    configureSocketTask()
    socketTask.resume()
  }
  
  private func configureSocketTask() {
    socketTask.receivePublisher()
      .subscribe(self)
  }
  
  private func makeMessageViewModels(messages: [Message]) -> [MessageViewModel] {
    messages.map(MessageViewModel.init)
  }
  
  func sendMessage(with text: String, completionHandler: ((Error?) -> Void)? = nil) {
    do {
      let message = Message(text: text, username: username.isEmpty ? nil : username)
      return try socketTask.send(.data(encoder.encode(message)), completionHandler: completionHandler ?? { _ in })
    } catch { fatalError(error.localizedDescription) }
  }
}

extension MessagesViewModel: Subscriber {
  typealias Input = URLSessionWebSocketTask.Message
  typealias Failure = Error
  
  func receive(subscription: Subscription) {}
  
  func receive(_ input: URLSessionWebSocketTask.Message) -> Subscribers.Demand {
    DispatchQueue.main.async {
      switch input {
      case .data(let data):
        do { try self.messages.insert(self.decoder.decode(Message.self, from: data), at: 0) }
        catch { print(error) }
      case .string: break
      @unknown default: break
      }
    }
    return .unlimited
  }
  
  func receive(completion: Subscribers.Completion<Error>) {}
}
