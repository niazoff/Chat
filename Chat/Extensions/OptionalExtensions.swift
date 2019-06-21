//
//  OptionalExtensions.swift
//  Chat
//
//  Created by Natanel Niazoff on 6/19/19.
//  Copyright © 2019 Natanel Niazoff. All rights reserved.
//

import Foundation

extension Optional {
  /// Either returns the `Wrapped` value if `some`
  /// or calls the `Never` value if none.
  /// For example, `value ?? preconditionFailure()`.
  static func ?? (lhs: Wrapped?, rhs: @autoclosure () -> Never) -> Wrapped {
    switch lhs {
    case .none: rhs()
    case .some(let unwrapped): return unwrapped
    }
  }
}
