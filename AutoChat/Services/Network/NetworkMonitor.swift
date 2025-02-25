import Foundation
import Network

class NetworkMonitor {
    static let shared = NetworkMonitor()
    
    private let monitor: NWPathMonitor
    private var status: NWPath.Status = .requiresConnection
    private var isReachable: Bool = true
    private var connectionType: ConnectionType = .unknown
    
    private var statusUpdateHandler: ((Bool, ConnectionType) -> Void)?
    
    enum ConnectionType {
        case wifi
        case cellular
        case ethernet
        case unknown
    }
    
    private init() {
        monitor = NWPathMonitor()
    }
    
    func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.status = path.status
            self?.isReachable = path.status != .unsatisfied
            self?.updateConnectionType(path)
            
            DispatchQueue.main.async {
                self?.statusUpdateHandler?(self?.isReachable ?? false, self?.connectionType ?? .unknown)
            }
        }
        
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
    
    func setUpdateHandler(_ handler: @escaping (Bool, ConnectionType) -> Void) {
        self.statusUpdateHandler = handler
    }
    
    private func updateConnectionType(_ path: NWPath) {
        if path.usesInterfaceType(.wifi) {
            connectionType = .wifi
        } else if path.usesInterfaceType(.cellular) {
            connectionType = .cellular
        } else if path.usesInterfaceType(.wiredEthernet) {
            connectionType = .ethernet
        } else {
            connectionType = .unknown
        }
    }
    
    var isConnected: Bool {
        return isReachable
    }
    
    var currentConnectionType: ConnectionType {
        return connectionType
    }
}