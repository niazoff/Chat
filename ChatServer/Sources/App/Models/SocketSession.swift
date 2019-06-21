import Vapor

class SocketSession {
  typealias ID = UUID
  
  let id: ID
  let socket: WebSocket
  
  init(id: ID = ID(),
       socket: WebSocket) {
    self.id = id
    self.socket = socket
  }
}
