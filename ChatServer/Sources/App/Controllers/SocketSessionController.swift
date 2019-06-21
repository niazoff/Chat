import Vapor

final class SocketSessionController {
  static var shared = SocketSessionController()
  
  private var sessions = [SocketSession]()
  
  private init() {}
  
  private func configure(_ session: SocketSession) {
    session.socket.onText { [weak self] in self?.send($1) }
    session.socket.onBinary { [weak self] in self?.send($1) }
    session.socket.onClose.always { [weak self] in
      self?.sessions.removeAll { $0.id == session.id }
      print("Did remove session with id: \(session.id).")
    }
  }
  
  private func send(_ text: String) {
    sessions.map { $0.socket }.forEach { $0.send(text) }
  }
  
  private func send(_ data: Data) {
    sessions.map { $0.socket }.forEach { $0.send(data) }
  }
  
  func add(_ session: SocketSession) throws {
    guard sessions.first(where: { $0.id == session.id }) == nil else {
      throw SocketSessionControllerError.sessionIDInUse
    }
    configure(session)
    sessions.append(session)
    print("Did add session with id: \(session.id).")
  }
  
  func add(_ socket: WebSocket, req: Request) throws {
    let id = try req.parameters.next(SocketSession.ID.self)
    try add(.init(id: id, socket: socket))
  }
}

enum SocketSessionControllerError: Error {
  case sessionIDInUse
}
