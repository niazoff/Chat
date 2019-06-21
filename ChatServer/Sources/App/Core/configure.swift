import Vapor

/// Called before the application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
  // Register routes to the router.
  let router = EngineRouter.default()
  try routes(router)
  services.register(router, as: Router.self)
  
  // Register sockets to the server.
  let socketServer = NIOWebSocketServer.default()
  sockets(socketServer)
  services.register(socketServer, as: WebSocketServer.self)
  
  // Register middleware.
  var middlewares = MiddlewareConfig()
  middlewares.use(ErrorMiddleware.self)
  services.register(middlewares)
}
