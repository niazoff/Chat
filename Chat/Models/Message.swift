//
//  Message.swift
//  Chat
//
//  Created by Natanel Niazoff on 6/19/19.
//  Copyright © 2019 Natanel Niazoff. All rights reserved.
//

import Foundation

struct Message: Codable {
  let id: UUID
  let date: Date
  let text: String
  let username: String?
  
  init(id: UUID = .init(),
       date: Date = .init(),
       text: String,
       username: String? = nil) {
    self.id = id
    self.date = date
    self.text = text
    self.username = username
  }
}
