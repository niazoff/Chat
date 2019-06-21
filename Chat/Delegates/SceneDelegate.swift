//
//  SceneDelegate.swift
//  Chat
//
//  Created by Natanel Niazoff on 6/18/19.
//  Copyright © 2019 Natanel Niazoff. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    if let windowScene = scene as? UIWindowScene {
      let window = makeWindow(windowScene: windowScene)
      self.window = window
      window.makeKeyAndVisible()
    }
  }
  
  func makeWindow(windowScene: UIWindowScene) -> UIWindow {
    let window = UIWindow(windowScene: windowScene)
    let rootViewController = makeWindowRootViewController()
    window.rootViewController = rootViewController
    return window
  }
  
  func makeWindowRootViewController() -> UIViewController {
    let viewModel = MessagesViewModel()
    return UIHostingController(rootView: MessagesView(viewModel: viewModel))
  }
}

