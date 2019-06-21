//
//  URLSession+WebSocketTaskPublisher.swift
//  Chat
//
//  Created by Natanel Niazoff on 6/19/19.
//  Copyright © 2019 Natanel Niazoff. All rights reserved.
//

import Foundation
import Combine

extension URLSession {
  struct WebSocketTaskPublisher: Publisher {
    typealias Output = URLSessionWebSocketTask.Message
    typealias Failure = Error
    
    let session: URLSession
    let request: URLRequest
    
    func receive<S>(subscriber: S) where S: Subscriber, Output == S.Input, Failure == S.Failure {
      let task = session.webSocketTask(with: request)
      task.receive { self.handle(result: $0, for: subscriber) }
      subscriber.receive(subscription: WebSocketTaskSubscription(task: task))
      task.resume()
    }
    
    func handle<S>(result: Result<URLSessionWebSocketTask.Message, Error>, for subscriber: S) where S: Subscriber, Output == S.Input, Failure == S.Failure {
      switch result {
      case .success(let message): _ = subscriber.receive(message)
      case .failure(let error): subscriber.receive(completion: .failure(error))
      }
    }
  }
}

extension URLSession {
  struct WebSocketTaskSubscription: Subscription {
    let combineIdentifier: CombineIdentifier
    let task: URLSessionWebSocketTask
    
    init(combineIdentifier: CombineIdentifier = .init(),
         task: URLSessionWebSocketTask) {
      self.combineIdentifier = combineIdentifier
      self.task = task
    }
    
    func request(_ demand: Subscribers.Demand) {}
    
    func cancel() { task.cancel() }
  }
}

extension URLSession {
  func webSocketTaskPublisher(with request: URLRequest) -> WebSocketTaskPublisher {
    WebSocketTaskPublisher(session: self, request: request)
  }
  
  func webSocketTaskPublisher(with url: URL) -> WebSocketTaskPublisher {
    WebSocketTaskPublisher(session: self, request: URLRequest(url: url))
  }
}
