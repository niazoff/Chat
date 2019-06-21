//
//  URLSessionWebSocketTask+RecievePublisher.swift
//  Chat
//
//  Created by Natanel Niazoff on 6/19/19.
//  Copyright © 2019 Natanel Niazoff. All rights reserved.
//

import Foundation
import Combine

extension URLSessionWebSocketTask {
  struct ReceivePublisher: Publisher {
    typealias Output = Message
    typealias Failure = Error
    
    let task: URLSessionWebSocketTask
    
    func receive<S>(subscriber: S) where S: Subscriber, Output == S.Input, Failure == S.Failure {
      configureTask(for: subscriber)
    }
    
    private func configureTask<S>(for subscriber: S) where S: Subscriber, Output == S.Input, Failure == S.Failure {
      task.receive { result in
        switch result {
        case .success(let message):
          _ = subscriber.receive(message)
          self.configureTask(for: subscriber)
        case .failure(let error):
          subscriber.receive(completion: .failure(error))
        }
      }
    }
  }
}

extension URLSessionWebSocketTask {
  func receivePublisher() -> ReceivePublisher {
    ReceivePublisher(task: self)
  }
}
