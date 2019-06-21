import Vapor

/// Registers the application's sockets.
public func sockets(_ socketServer: WebSocketServer) {
  guard let socketServer = socketServer as? NIOWebSocketServer else { return }
  
  let sessionController = SocketSessionController.shared
  socketServer.get("sessions", SocketSession.ID.parameter, use: sessionController.add)
}
